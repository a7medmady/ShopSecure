import 'package:e_commerce/auth/widgets/button.dart';
import 'package:e_commerce/auth/widgets/customForm.dart';
import 'package:e_commerce/auth/widgets/secretForm.dart';
import 'package:e_commerce/constants/appColor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String routename = 'login';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: AppFonts.large,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'It’s great to see you again.',
                  style: TextStyle(
                    fontSize: AppFonts.medium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                CustomForm(
                  title: 'Email',
                  subtitle: 'Enter your email address',
                  controller: email,
                ),
                SecretForm(
                  title: 'Password',
                  subtitle: 'Enter your password',
                  controller: password,
                  parentController: null,
                ),

                SizedBox(height: 50.h),

                Center(
                  child: Button(
                    title: 'Sign In',
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.pushNamed(context, 'display');
                      }
                    },
                  ),
                ),
                SizedBox(height: 280.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          fontSize: AppFonts.medium,
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Join',
                            style: TextStyle(
                              fontSize: AppFonts.medium,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, 'register'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
