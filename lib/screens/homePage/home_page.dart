import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_gamification.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_sensors.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_suggestions.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CardGamification(),
              ),
              SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CardSuggestions(),
              ),
              SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CardSensor(),
              ),
              SizedBox(height: 45),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: BottomButton(
                    false, primaryColor, customColor, "Meus dispositivos", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DevicePage()));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
