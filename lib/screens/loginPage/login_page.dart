import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/bottomNavigationBarMenu/bottom_navigation_bar_menu.dart';
import 'package:smart_chair_frontend/screens/createAccountPage/create_account_page.dart';
import 'package:smart_chair_frontend/screens/introPage/intro_page.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  height: 150),
              Container(
                padding: EdgeInsets.all(15),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    controller: nameController,
                    validator: (val) {
                      if (val.isEmpty) return "O nome não pode ser vazio";
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    controller: passwordController,
                    validator: (val) {
                      if (val.isEmpty) return "A senha não pode ser vazia";
                      return null;
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: GestureDetector(
                    /*onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashPage()));
                    },*/
                    child: Text(
                      "Esqueci minha senha",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: BottomButton(primaryColor, customColor, "Login", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IntroPage()));
                }),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Não tem conta? "),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()));
                        },
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
