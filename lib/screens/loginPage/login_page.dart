import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/http/user_controller.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/screens/createAccountPage/create_account_page.dart';
import 'package:smart_chair_frontend/screens/introPage/intro_page.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
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
              child: Form(
                key: _form,
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Login'),
                    controller: nameController,
                    validator: (val) {
                      if (val.isEmpty) return "O nome não pode ser vazio";
                      return null;
                    },
                  ),
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
              child: BottomButton(primaryColor, customColor, "Login", () async {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => IntroPage()));
                User user = User();

                user.email = nameController.text;
                user.password = passwordController.text;

                if (_form.currentState.validate()) {
                  var msg = await login(user);
                  if (msg == '200') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IntroPage()));
                  } else {
                    //_showToast(context, msg);
                    _showAlertDialog(context, msg);
                  }
                }
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
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(msg),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
