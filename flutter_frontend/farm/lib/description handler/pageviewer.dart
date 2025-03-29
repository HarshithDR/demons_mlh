import 'package:farm/description%20handler/description1.dart';
import 'package:farm/description%20handler/description2.dart';
import 'package:farm/description%20handler/description3.dart';
import 'package:flutter/material.dart';

class Pageviewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _pcontroller = new PageController();
    return PageView(
      children: [
        Description1(pController: _pcontroller),
        Description2(pController: _pcontroller),
        Description3(pController: _pcontroller),
      ],
      controller: _pcontroller,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
