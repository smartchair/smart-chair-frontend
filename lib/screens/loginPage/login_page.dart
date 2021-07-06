import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/bottomNavigationBarMenu/bottom_navigation_bar_menu.dart';
import 'package:smart_chair_frontend/errorBoxWidget/error_box.dart';
import 'package:smart_chair_frontend/screens/createAccountPage/create_account_page.dart';
import 'package:smart_chair_frontend/stores/login_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BottomNavigationBarMenu()));
    });
  }

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
            Observer(
              builder: (_) => Padding(
                padding: EdgeInsets.all(8),
                child: ErrorBox(
                  message: loginStore.error,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ListTile(
                title: Observer(
                  builder: (_) => TextFormField(
                      onChanged: loginStore.setEmail,
                      decoration: InputDecoration(
                          labelText: 'Email', errorText: loginStore.emailError),
                      controller: nameController),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ListTile(
                title: Observer(
                  builder: (_) => TextFormField(
                      onChanged: loginStore.setPass,
                      decoration: InputDecoration(
                          labelText: 'Senha', errorText: loginStore.passError),
                      controller: passwordController),
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
            Observer(
              builder: (_) => Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: BottomButton(loginStore.loading, primaryColor,
                    customColor, "Entrar", loginStore.logInPressed),
              ),
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
}
