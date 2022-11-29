import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/home/screenhome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
            splashTransition: SplashTransition.fadeTransition,
            splashIconSize: 200,
            splash: Image.asset(
              'assets/logo2.png',
              fit: BoxFit.fitWidth,
            ),
            backgroundColor: Colors.white,
            nextScreen: ScreenHome()),
      ),
    );
  }
}
