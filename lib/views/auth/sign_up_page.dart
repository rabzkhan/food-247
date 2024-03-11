import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/validators.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController countryCodeController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: Text(
                      'Welcome to our\nfood shop',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
                Container(
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: AppDefaults.boxShadow,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: Form(
                    key: formKey,
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
                                onChanged: (value) => countryCodeController.text = value.dialCode!,
                                showFlag: false,
                                initialSelection: 'IT',
                                favorite: ['+39', 'FR'],
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
                        const Text("Email"),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          validator: Validators.requiredWithFieldName('Email'),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppDefaults.padding),
                        const Text("Password"),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordController,
                          validator: Validators.requiredWithFieldName('Password'),
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  AppIcons.eye,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDefaults.padding),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
                          child: Row(
                            children: [
                              Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    var arguments = {
                                      "email": emailController.text.toString(),
                                      "country_code": countryCodeController.text.toString(),
                                      "phone": phoneNumberController.text.toString(),
                                      "password": passwordController.text.toString(),
                                    };
                                    authController.signUp(arguments);
                                  }
                                },
                                style: ElevatedButton.styleFrom(elevation: 1),
                                child: SvgPicture.asset(
                                  AppIcons.arrowForward,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already Have Account?'),
                            TextButton(
                              onPressed: () => {},
                              child: const Text('Log In'),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDefaults.padding),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
