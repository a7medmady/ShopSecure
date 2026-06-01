import 'package:e_commerce/auth/widgets/button.dart';
import 'package:e_commerce/auth/widgets/customForm.dart';
import 'package:e_commerce/auth/widgets/secretForm.dart';
import 'package:e_commerce/constants/appColor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String routename = 'register';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController passUp = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: 70, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: AppFonts.large,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Let’s create your account.',
                  style: TextStyle(
                    fontSize: AppFonts.medium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                CustomForm(
                  title: 'Full Name',
                  subtitle: 'Enter your full name',
                  controller: fullName,
                ),
                CustomForm(
                  title: 'Email',
                  subtitle: 'Enter your email address',
                  controller: userName,
                ),

                SecretForm(
                  title: 'Password',
                  subtitle: 'Enter your password',
                  controller: pass,
                  parentController: null,
                ),

                SecretForm(
                  title: 'Confirm Password',
                  subtitle: 'Enter your confirm password',
                  controller: passUp,
                  parentController: pass,
                ),

                SizedBox(height: 50.h),

                Center(
                  child: Button(
                    title: 'Create Account',
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.pushNamed(context, 'login');
                      }
                    },
                  ),
                ),

                SizedBox(height: 70.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontSize: AppFonts.medium,
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: "Log In",
                            style: TextStyle(
                              fontSize: AppFonts.medium,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, 'login');
                              },
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
