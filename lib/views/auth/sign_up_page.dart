import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../../core/components/toast_message.dart';
import '../../core/constants/constants.dart';
import '../../core/themes/app_themes.dart';
import '../../core/utils/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());
  bool isPasswordShown = false;

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd7eab0),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 40.h),
              child: Image.asset(AppIcons.authBg),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: AppDefaults.boxShadow,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Text(
                        'Sign to your account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                      ),
                      10.verticalSpace,
                      Theme(
                        data: AppTheme.defaultTheme.copyWith(
                          inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Phone Number"),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CountryCodePicker(
                                      onChanged: (value) => authController.countryCodeController.text = value.dialCode!,
                                      onInit: (value) => authController.countryCodeController.text = value!.dialCode!,
                                      showFlag: false,
                                      initialSelection: 'US',
                                      favorite: const ['+1', 'US'],
                                      showCountryOnly: true,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: true,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: authController.phoneNumberController,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.requiredWithFieldName('Phone number'),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDefaults.padding),
                              const Text("Email"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: authController.emailController,
                                validator: Validators.requiredWithFieldName('Email'),
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: AppDefaults.padding),
                              const Text("Password"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: authController.passwordController,
                                validator: Validators.requiredWithFieldName('Password'),
                                textInputAction: TextInputAction.next,
                                obscureText: !isPasswordShown,
                                decoration: InputDecoration(
                                  suffixIcon: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: onPassShowClicked,
                                      icon: SvgPicture.asset(
                                        AppIcons.eye,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text("Confirm Password"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: authController.confirmPasswordController,
                                validator: Validators.requiredWithFieldName('Password'),
                                textInputAction: TextInputAction.next,
                                obscureText: !isPasswordShown,
                                decoration: InputDecoration(
                                  suffixIcon: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: onPassShowClicked,
                                      icon: SvgPicture.asset(
                                        AppIcons.eye,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              20.verticalSpace,
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    var arguments = {
                                      "email": authController.emailController.text.toString(),
                                      "country_code": authController.countryCodeController.text.toString(),
                                      "phone": authController.phoneNumberController.text.toString(),
                                      "password": authController.passwordController.text.toString(),
                                    };
                                    if (authController.confirmPasswordController.text.toString() ==
                                        authController.passwordController.text.toString()) {
                                      authController.signUp(arguments);
                                    } else {
                                      showToast("Passwod didn't matched!");
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6.h),
                                    child: const Text('Sign Up'),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already Have Account?'),
                                  TextButton(
                                    onPressed: () => {Get.back()},
                                    child: const Text('Log In'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
