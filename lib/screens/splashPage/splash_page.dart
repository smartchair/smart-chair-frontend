import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/utils/util_navigator.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with NavigatorUtil {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((_) {
      nextScreenNoReturn(context, LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          child: Image.asset("assets/logo_tcc.png"),
        ),
      ),
    );
  }
}
