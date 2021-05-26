import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/homePage/home_page.dart';
import 'package:smart_chair_frontend/utils/const.dart';

import 'widgets/card_intro.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olá Fulano, como você está hoje?',
                style: TextStyle(fontSize: 23, color: customColor)),
            SizedBox(height: 45),
            CardsIntro('Estou bem!', 'assets/happiness.png'),
            SizedBox(height: 45),
            CardsIntro('Está tudo certo!', 'assets/bored.png'),
            SizedBox(height: 45),
            CardsIntro('Podia estar melhor!', 'assets/sad.png'),
            SizedBox(height: 45)
          ],
        ),
      ),
    );
  }
}
