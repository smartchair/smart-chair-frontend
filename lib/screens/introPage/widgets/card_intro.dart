import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomNavigationBarMenu/bottom_navigation_bar_menu.dart';
import 'package:smart_chair_frontend/screens/homePage/home_page.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class CardsIntro extends StatelessWidget {
  final String content;
  final String image;

  CardsIntro(this.content, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey.shade300,
        child: InkWell(
          onTap: () {
            print(content);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarMenu()));
          },
          enableFeedback: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(content,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: customColor)),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                alignment: Alignment.topCenter,
              ),
              Image.asset(image, width: 50, height: 50, color: customColor)
            ],
          ),
        ),
      ),
    );
  }
}
