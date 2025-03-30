import 'package:farm/starter%20pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class Description3 extends StatefulWidget {
  final PageController pController;
  const Description3({super.key, required this.pController});

  @override
  State<Description3> createState() => _Description3State();
}

class _Description3State extends State<Description3> {
  @override
  bool opac1 = true;
  bool opac2 = true;
  bool opac3 = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opac1 = false;
      });
    });
    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        opac2 = false;
      });
    });
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        opac3 = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const glowColor = Color.fromARGB(255, 235, 89, 10);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          'PyroWatch',
          style: GoogleFonts.abrilFatface(
            color: const Color.fromARGB(255, 255, 55, 0),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        // leading: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 41, 2, 2),
              const Color.fromARGB(255, 0, 0, 0),
              const Color.fromARGB(255, 41, 2, 2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: opac1 ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/flame2.gif',
                    width: double.infinity,
                    scale: 0.1,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: AnimatedOpacity(
                  opacity: opac2 ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'We Offer Smart Solutions for Wildfire Prevention\nWith advanced sensors, predictive alerts, and smart monitoring, we empower you to take control of your land’s safety and protect it from fire threats.',
                    style: GoogleFonts.abhayaLibre(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              AnimatedOpacity(
                opacity: opac3 ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withOpacity(0.7),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 16,
                      ),
                      side: BorderSide(color: glowColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Welcome()),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
