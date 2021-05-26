import 'package:flutter/cupertino.dart';

class ScreenUtil {
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
