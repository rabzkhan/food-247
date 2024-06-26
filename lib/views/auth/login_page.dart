import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/themes/app_themes.dart';
import '../../core/utils/validators.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.put(AuthController());
  final _key = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordShown = false;
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      var arguments = {
        "country_code": countryCodeController.text.toString(),
        "phone": phoneNumberController.text.toString(),
        "password": passwordController.text.toString(),
      };
      Logger().d(arguments);
      authController.signIn(arguments);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd7eab0),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 80.h),
              child: Image.asset(AppIcons.authBg),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  //margin: const EdgeInsets.all(AppDefaults.margin),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      20.verticalSpace,
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                      ),
                      20.verticalSpace,
                      Theme(
                        data: AppTheme.defaultTheme.copyWith(
                          inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
                        ),
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Phone Field
                              const Text("Phone Number"),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CountryCodePicker(
                                      onChanged: (value) => countryCodeController.text = value.dialCode!,
                                      onInit: (value) => countryCodeController.text = value!.dialCode!,
                                      showFlag: false,
                                      initialSelection: 'US',
                                      favorite: ['+1', 'US'],
                                      showCountryOnly: true,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: true,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: phoneNumberController,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.requiredWithFieldName('Phone number'),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDefaults.padding),

                              // Password Field
                              const Text("Password"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: passwordController,
                                validator: Validators.requiredWithFieldName('Password'),
                                onFieldSubmitted: (v) => onLogin(),
                                textInputAction: TextInputAction.done,
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

                              40.verticalSpace,

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    onLogin();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6.h),
                                    child: const Text('Login'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t Have Account?'),
                          TextButton(
                            onPressed: () => Get.to(() => SignUpPage()),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                      100.verticalSpace,
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
