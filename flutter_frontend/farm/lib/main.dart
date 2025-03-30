import 'farmsplashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyFarm());

class MyFarm extends StatelessWidget {
  const MyFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FarmSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
