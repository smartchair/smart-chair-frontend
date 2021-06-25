import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_gamification.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_sensors.dart';
import 'package:smart_chair_frontend/screens/homePage/widgets/card_suggestions.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ChairStore chairStore = GetIt.I<ChairStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => userManagerStore.user.chairs.keys.isEmpty, () {
      chairStore.getChair();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
