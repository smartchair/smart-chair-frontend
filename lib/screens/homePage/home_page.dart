import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_gamification.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_sensors.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_suggestions.dart';
import 'package:smart_chair_frontend/screens/introPage/widgets/card_intro.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 45),
            CardGamification(),
            SizedBox(height: 45),
            CardSuggestions(),
            SizedBox(height: 45),
            CardSensor(),
            SizedBox(height: 45),
            BottomButton(primaryColor, customColor, "Meus dispositivos", () {
              print("dispositivos");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DevicePage()));
            })
          ],
        ),
      ),
    );
  }
}
