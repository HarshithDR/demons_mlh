import 'package:farm/description%20handler/description1.dart';
import 'package:farm/description%20handler/description2.dart';
import 'package:farm/description%20handler/description3.dart';
import 'package:flutter/material.dart';

class Pageviewer extends StatelessWidget {
  const Pageviewer({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pcontroller = PageController();
    return PageView(
      children: [
        Description1(pController: pcontroller),
        Description2(pController: pcontroller),
        Description3(pController: pcontroller),
      ],
      controller: pcontroller,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
