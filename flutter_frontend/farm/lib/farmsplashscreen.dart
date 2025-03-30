import 'package:farm/description%20handler/pageviewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmSplashScreen extends StatefulWidget {
  const FarmSplashScreen({super.key});

  @override
  State<FarmSplashScreen> createState() => _FarmSplashScreenState();
}

class _FarmSplashScreenState extends State<FarmSplashScreen> {
  bool opac1 = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        opac1 = false;
      });
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        opac1 = true;
      });
    });
    Future.delayed(Duration(milliseconds: 3100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pageviewer()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opac1 ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Image.asset('assets/images/logo.png', scale: 3),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
