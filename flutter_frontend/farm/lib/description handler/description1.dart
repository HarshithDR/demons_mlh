import 'package:farm/description%20handler/description2.dart';
import 'package:flutter/material.dart';

class Description1 extends StatefulWidget {
  final PageController pController;
  Description1({required this.pController});

  @override
  State<Description1> createState() => _Description1State();
}

class _Description1State extends State<Description1> {
  @override
  void initState() {
    super.initState();
  }

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
                  scale: 0.1,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Text(
                'Protect Your Land with Cutting-Edge Technology!\nWith real-time data, predictive alerts, and smart monitoring, stay ahead of potential fire risks and safeguard your land.',
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
                  widget.pController.nextPage(
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
