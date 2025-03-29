import 'package:farm/description%20handler/description3.dart';
import 'package:flutter/material.dart';

class Description2 extends StatelessWidget {
  final PageController pController;
  Description2({required this.pController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.black,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/flame2.gif',
                  width: double.infinity,
                  scale: 0.5,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Text(
                'Stay Ahead of Wildfires with Smart Hardware!\nSmart sensors detect potential fire hazards early, sending alerts directly to your device!',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 157, 56, 5),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  pController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic,
                  );
                },
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
