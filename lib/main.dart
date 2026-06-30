import 'package:e_commerce/core/Splash/screens/pageView.dart';
import 'package:e_commerce/core/Splash/screens/splash.dart';
import 'package:e_commerce/core/auth/cubit/cubit.dart';
import 'package:e_commerce/core/auth/screens/login.dart';
import 'package:e_commerce/core/auth/screens/signUp.dart';
import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:e_commerce/core/home/cubit/cubit.dart';
import 'package:e_commerce/core/home/screens/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cachehelper.initial();
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
