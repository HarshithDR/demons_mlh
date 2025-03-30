import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_background/animated_background.dart';

class JsonTableScreen extends StatefulWidget {
  @override
  _JsonTableScreenState createState() => _JsonTableScreenState();
}

class _JsonTableScreenState extends State<JsonTableScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> data = {}; // Change to hold a Map
  bool isLoading = false;

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse(
        'https://vercel-zz1tl98to-nishchals-projects-80d9f9a5.vercel.app/api/check-fire',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const glowColor = Color.fromARGB(255, 235, 89, 10);
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 25, 41, 0.5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 55, 0)),
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
      body: Stack(
        children: [
          AnimatedBackground(
            child: Text(''),
            vsync: this,
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.orange,
                particleCount: 50,
                spawnMaxSpeed: 20,
                spawnMinSpeed: 15,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.height / 4,
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
                      fetchData();
                    },
                    child: const Text(
                      'Fetch Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height / 20),
              isLoading
                  ? CircularProgressIndicator(color: Colors.deepOrange[600])
                  : Expanded(child: buildTable()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable() {
    if (data.isEmpty)
      return Text('No data available', style: TextStyle(color: Colors.white));

    // Extract data
    String alert = data["alert"];
    Map<String, dynamic> details = data["details"];

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade100,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrangeAccent.withOpacity(0.9),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            // Display the alert at the top
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                alert,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Display details in a title-attribute format
            Column(
              children:
                  details.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "${entry.key} : ${entry.value}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
