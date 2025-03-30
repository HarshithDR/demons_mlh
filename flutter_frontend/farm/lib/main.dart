import 'package:farm/farmhome.dart';
import 'package:farm/farmsplashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyFarm());

class MyFarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FarmSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
