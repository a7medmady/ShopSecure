import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

String routename = 'splash';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      if (Cachehelper.contain(key: 'isNotFirstUsingApp')) {
        if (!Cachehelper.contain(key: 'username')) {
          Navigator.pushNamed(context, 'login');
        } else {
          Navigator.pushNamed(context, 'display');
        }
      } else {
        Navigator.pushNamed(context, 'page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/Online Shopping.json'),
          SizedBox(height: 40),
          CircularProgressIndicator(strokeWidth: 2),
        ],
      ),
    );
  }
}
