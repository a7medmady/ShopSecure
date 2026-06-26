import 'package:e_commerce/core/auth/cubit/cubit.dart';
import 'package:e_commerce/core/auth/cubit/state.dart';
import 'package:e_commerce/core/auth/widgets/button.dart';
import 'package:e_commerce/core/auth/widgets/customForm.dart';
import 'package:e_commerce/core/auth/widgets/secretForm.dart';
import 'package:e_commerce/core/constants/appColor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String routename = 'register';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Account created successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFonts.small,
                ),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          AuthCubit.get(context).restore();
          Navigator.pushNamed(context, 'login');
          AuthCubit.get(context).clearSignUp();
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFonts.small,
                ),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          AuthCubit.get(context).restore();
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Form(
          key: formkey,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
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
                    SizedBox(height: 5.h),
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
                      controller: cubit.fullName,
                    ),
                    CustomForm(
                      title: 'User Name',
                      subtitle: 'Enter your full name',
                      controller: cubit.userName,
                    ),
                    CustomForm(
                      title: 'Phone',
                      subtitle: 'Enter your phone number',
                      controller: cubit.phone,
                    ),

                    SecretForm(
                      title: 'Password',
                      subtitle: 'Enter your password',
                      controller: cubit.pass,
                      parentController: null,
                      textInputAction: TextInputAction.next,
                    ),

                    SecretForm(
                      title: 'Confirm Password',
                      subtitle: 'Enter your confirm password',
                      controller: cubit.passUp,
                      parentController: cubit.pass,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: 30.h),

                    Center(
                      child: state is SignUpLoading
                          ? CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : Button(
                              title: 'Create Account',
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.signUp();
                                }
                              },
                            ),
                    ),

                    SizedBox(height: 40.h),

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
      },
    );
  }
}
