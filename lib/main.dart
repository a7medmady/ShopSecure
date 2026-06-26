import 'package:e_commerce/Splash/screens/pageView.dart';
import 'package:e_commerce/Splash/screens/splash.dart';
import 'package:e_commerce/auth/cubit/cubit.dart';
import 'package:e_commerce/auth/screens/login.dart';
import 'package:e_commerce/auth/screens/signUp.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/screens/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => HomeCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'login': (context) => const Login(),
            'register': (context) => const SignUp(),
            'display': (context) => const Display(),
            'page': (context) => const Boarding(),
            'splash': (context) => const Splash(),
          },
          initialRoute: 'splash',
        ),
      ),
    );
  }
}
