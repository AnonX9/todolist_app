import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: const HomePage(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(seconds: 50)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appBarTitleStyle = theme.textTheme.displayLarge!
        .copyWith(fontFamily: "Pacifico", color: colorScheme.inversePrimary);

    return Scaffold(
      backgroundColor: colorScheme.inversePrimary,
      body: Stack(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: colorScheme.surface,
              radius: 150,
              child: Text("TodoList", style: appBarTitleStyle),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.4),
            child: CircleAvatar(
              backgroundColor: colorScheme.inversePrimary,
              radius: 50,
            ),
          ),
          Align(
            alignment: const Alignment(0.3, -0.2),
            child: CircleAvatar(
              backgroundColor: colorScheme.inversePrimary,
              radius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
