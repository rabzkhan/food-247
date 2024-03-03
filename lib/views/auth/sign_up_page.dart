import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/validators.dart';
import '../parent/parent_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: AppDefaults.padding),
                Container(
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: AppDefaults.boxShadow,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name"),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: Validators.requiredWithFieldName('Name'),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Phone Number"),
                      const SizedBox(height: 8),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: Validators.required,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Password"),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: Validators.required,
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
                              onPressed: () {
                                Get.offAll(() => ParentPage());
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
