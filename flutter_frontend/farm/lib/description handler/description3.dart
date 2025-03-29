import 'package:farm/farmhome.dart';
import 'package:flutter/material.dart';

class Description3 extends StatelessWidget {
  final PageController pController;
  Description3({required this.pController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
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
                'We Offer Smart Solutions for Wildfire Prevention!\nWith advanced sensors, predictive alerts, and smart monitoring, we empower you to take control of your land’s safety and protect it from fire threats.',
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Farmhome()),
                  );
                },
                child: Text("Skip"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
