import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logger/logger.dart';
import '../components/custom_snackbar.dart';
import 'api_exceptions.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  )
      // ..interceptors.add(
      //     PrettyDioLogger(
      //       requestHeader: true,
      //       requestBody: true,
      //       responseBody: true,
      //       responseHeader: false,
      //       error: true,
      //       compact: true,
      //       maxWidth: 90,
      //     ),
      //   )
      ;

  // request timeout (default 10 seconds)
  static const int _timeoutInSeconds = 10;

  /// dio getter (used for testing)
  static get dio => _dio;

  /// perform safe api request
  static apiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      await onLoading?.call();
      // 2) try to perform http request
      late Response response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
      } else if (requestType == RequestType.post) {
        Logger().d(data);
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else {
        response = await _dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      _handleDioError(error: error, url: url, onError: onError);
    } on SocketException {
      // No internet connection
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      // Api call went out of time
      _handleTimeoutException(url: url, onError: onError);
    } catch (error, stackTrace) {
      // print the line of code that throw unexpected exception
      Logger().e(stackTrace);
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// handle unexpected error
  static _handleUnexpectedException({Function(ApiException)? onError, required String url, required Object error}) {
    if (onError != null) {
      onError(ApiException(
        message: error.toString(),
        url: url,
      ));
    } else {
      _handleError(error.toString());
    }
  }

  /// handle timeout exception
  static _handleTimeoutException({Function(ApiException)? onError, required String url}) {
    if (onError != null) {
      onError(ApiException(
        message: ApiExceptionMessage.serverNotResponding.tr,
        url: url,
      ));
    } else {
      _handleError(ApiExceptionMessage.serverNotResponding.tr);
    }
  }

  /// handle timeout exception
  static _handleSocketException({Function(ApiException)? onError, required String url}) {
    if (onError != null) {
      onError(ApiException(
        message: ApiExceptionMessage.noInternetConnection.tr,
        url: url,
      ));
    } else {
      _handleError(ApiExceptionMessage.noInternetConnection.tr);
    }
  }

  /// handle Dio error
  static _handleDioError({required DioException error, Function(ApiException)? onError, required String url}) {
    // 404 error
    if (error.response?.statusCode == 404) {
      if (onError != null) {
        return onError(ApiException(
          message: ApiExceptionMessage.urlNotFound.tr,
          url: url,
          statusCode: 404,
        ));
      } else {
        return _handleError(ApiExceptionMessage.urlNotFound.tr);
      }
    }

    // no internet connection
    if (error.message != null && error.message!.toLowerCase().contains('socket')) {
      if (onError != null) {
        return onError(ApiException(
          message: ApiExceptionMessage.noInternetConnection.tr,
          url: url,
        ));
      } else {
        return _handleError(ApiExceptionMessage.noInternetConnection.tr);
      }
    }

    // check if the error is 500 (server problem)
    if (error.response?.statusCode == 500) {
      var exception = ApiException(
        message: ApiExceptionMessage.serverError.tr,
        url: url,
        statusCode: 500,
      );

      if (onError != null) {
        return onError(exception);
      } else {
        return handleApiError(exception);
      }
    }

    var exception = ApiException(
        url: url,
        message: error.message ?? 'Un Expected Api Error!',
        response: error.response,
        statusCode: error.response?.statusCode);
    if (onError != null) {
      return onError(exception);
    } else {
      return handleApiError(exception);
    }
  }

  /// handle error automaticly (if user didnt pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason (the dio message)
  static handleApiError(ApiException apiException) {
    String msg = apiException.toString();
    CustomSnackBar.showCustomErrorToast(message: msg);
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static _handleError(String msg) {
    CustomSnackBar.showCustomErrorToast(message: msg);
  }
}
