import 'dart:convert';
import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_background/animated_background.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart'; // For sound notification

class JsonTableScreen extends StatefulWidget {
  const JsonTableScreen({super.key});

  @override
  _JsonTableScreenState createState() => _JsonTableScreenState();
}

class _JsonTableScreenState extends State<JsonTableScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> data = {};
  bool isLoading = false;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  @override
  void initState() {
    super.initState();
    if (mounted) fetchData(); // Initial fetch when screen loads
    _startAutoFetch(); // Start fetching immediately and every 2 seconds
  }

  // Start fetching data every 2 seconds
  void _startAutoFetch() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      fetchData();
    });
  }

  // Fetch data from the API
  Future<void> fetchData() async {
    setState(() => isLoading = true);

    try {
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

        // Check if fire is detected and play sound if true
        String fireDetected = data["details"]["Fire_Detected"] ?? "No";
        if (fireDetected.toLowerCase() == "yes") {
          _playFireSound();
        }
      } else {
        setState(() => isLoading = false);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching data: $e');
    }
  }

  // Play the fire sound if fire is detected
  void _playFireSound() async {
    // Assuming 'fire.mp3' is in your assets folder
    await _audioPlayer.play(AssetSource('images/fire.mp3'));
  }

  void openGoogleMaps(String gps) async {
    List<String> coordinates = gps.split(",");
    if (coordinates.length == 2) {
      String latitude = coordinates[0].trim();
      String longitude = coordinates[1].trim();
      final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      );

      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        print('Could not launch Google Maps');
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 25, 41, 0.5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _audioPlayer.pause();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 55, 0)),
        ),
        title: Text(
          'Smart Farm',
          style: GoogleFonts.abrilFatface(
            color: Color.fromARGB(255, 255, 55, 0),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(9, 23, 37, 0.345),
        elevation: 6,
      ),
      body: Stack(
        children: [
          AnimatedBackground(
            vsync: this,
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.orange,
                particleCount: 50,
                spawnMaxSpeed: 20,
                spawnMinSpeed: 15,
              ),
            ),
            child: Container(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: fetchData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Fetch Data',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator(color: Colors.deepOrange)
                else
                  buildTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTable() {
    if (data.isEmpty) {
      return Text('No data available', style: TextStyle(color: Colors.white));
    }

    // Extract data
    String alert = data["alert"] ?? "No Alert";
    Map<String, dynamic> details = data["details"] ?? {};
    String fireDetected = details["Fire_Detected"] ?? "No";
    String gps = details["GPS"] ?? "0,0";

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
            SizedBox(height: 15),
            // Show the Map button only if fire is detected
            if (fireDetected.toLowerCase() == "yes")
              ElevatedButton(
                onPressed: () => openGoogleMaps(gps),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Map',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
