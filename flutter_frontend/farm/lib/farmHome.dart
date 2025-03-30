import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'backend_integration/recent_alert.dart';

class Farmhome extends StatefulWidget {
  @override
  State<Farmhome> createState() => _FarmhomeState();
}

class _FarmhomeState extends State<Farmhome>
    with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
  }

  Widget textfielder(String helperText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          helperText: helperText,
          helperStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const glowColor = Color.fromARGB(255, 235, 89, 10);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Farm',
          style: GoogleFonts.abrilFatface(
            color: const Color.fromARGB(255, 255, 55, 0),
          ),
        ),
        centerTitle: true,
        // leading: Image.asset('assets/images/logo.png'),
        backgroundColor: Color.fromRGBO(9, 23, 37, 0.345),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      // backgroundColor: const Color.fromARGB(120, 30, 29, 51),
      backgroundColor: Color.fromRGBO(10, 25, 41, 0.5),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          AnimatedBackground(
            child: Text(''),
            vsync: this,
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.orange,
                particleCount: 50,
                spawnMinSpeed: 15,
                spawnMaxSpeed: 20,
              ),
            ),
          ),

          ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    //
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'HI CLAUDIA',
                          textStyle: TextStyle(
                            fontSize: 50.0, // Bigger font size
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            shadows: [
                              Shadow(
                                blurRadius: 25.0,
                                color: Colors.deepOrange,
                              ),
                              Shadow(
                                blurRadius: 50.0,
                                color: Colors.deepOrange,
                              ),
                            ],
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                    SizedBox(height: 20), // Space between texts
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Welcome to PyroWatch',
                            textStyle: TextStyle(
                              wordSpacing: 2,
                              fontSize: 30.0, // Smaller than "HI CLAUDIA"
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange,
                              shadows: [
                                Shadow(
                                  blurRadius: 15.0,
                                  color: Colors.deepOrange,
                                ),
                                Shadow(
                                  blurRadius: 30.0,
                                  color: Colors.deepOrange,
                                ),
                              ],
                            ),
                            speed: Duration(milliseconds: 100),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Animate(
                      effects: [FadeEffect(), ScaleEffect()],
                      child: Image.asset('assets/images/rpi.png', scale: 1.7),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Container(
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
                          showDialog(
                            context: context,
                            builder:
                                (context) => BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5,
                                    sigmaY: 5,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AlertDialog(
                                          iconColor: Colors.red,
                                          icon: Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close_outlined),
                                            ),
                                          ),

                                          backgroundColor: const Color.fromARGB(
                                            207,
                                            74,
                                            72,
                                            85,
                                          ),
                                          actions: [
                                            Column(
                                              children: [
                                                Animate(
                                                  effects: [ScaleEffect()],
                                                  child: Text(
                                                    "It's time to unbox your new device",
                                                    style:
                                                        GoogleFonts.abyssinicaSil(
                                                          color: glowColor,
                                                          fontSize: 24,
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      70,
                                                ),
                                                Image.asset(
                                                  'assets/images/Gift.gif',
                                                  scale: 1.5,
                                                ),

                                                textfielder("Device ID"),
                                                SizedBox(
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      60,
                                                ),

                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: glowColor
                                                            .withOpacity(0.7),
                                                        blurRadius: 15,
                                                        spreadRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 50,
                                                            vertical: 16,
                                                          ),
                                                      side: BorderSide(
                                                        color: glowColor,
                                                        width: 2,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      'Save',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      60,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: const Text(
                          'Add device',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Container(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JsonTableScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Recent Alerts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
