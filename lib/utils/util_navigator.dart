import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  void nextScreenNoReturn(BuildContext context, StatefulWidget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  void nextScreenReturn(BuildContext context, StatefulWidget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
