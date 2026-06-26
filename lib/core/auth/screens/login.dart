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

String routename = 'login';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login successfully',
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
          Navigator.pushNamed(context, 'display');
          AuthCubit.get(context).clearLogin();
        } else if (state is SignInError) {
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
                      title: 'Username',
                      subtitle: 'Enter your User name',
                      controller: cubit.email,
                    ),
                    SecretForm(
                      title: 'Password',
                      subtitle: 'Enter your password',
                      controller: cubit.password,
                      parentController: null,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: 50.h),

                    Center(
                      child: state is SignInLoading
                          ? CircularProgressIndicator()
                          : Button(
                              title: 'Sign In',
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.signIn();
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
      },
    );
  }
}
