import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
import 'package:smart_chair_frontend/errorBoxWidget/error_box.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/stores/create_account_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';
import 'package:smart_chair_frontend/utils/util_navigator.dart';
import 'package:smart_chair_frontend/utils/util_screen.dart';
import '../../bottomButtonWidget/bottom_button.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage>
    with ScreenUtil, NavigatorUtil {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final CreateAccountStore _createAccountStore = CreateAccountStore();

  @override
  void initState() {
    super.initState();

    when((_) => _createAccountStore.result == 'Usuário criado com sucesso', () {
      _showAlertDialog(context, _createAccountStore.result);
    });
  }

  Future<String> loadingTime() async {
    return Future.delayed(Duration(seconds: 5))
        .then((value) => 'Loading is done!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.transparent,
              height: 580,
              width: 350,
              child: Form(
                key: _form,
                child: Padding(
                  padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Observer(
                          builder: (_) =>
                              ErrorBox(message: _createAccountStore.error)),
                      ListTile(
                        title: Observer(
                          builder: (_) => TextFormField(
                            onChanged: _createAccountStore.setName,
                            decoration: InputDecoration(
                                labelText: 'Nome',
                                errorText: _createAccountStore.nameError),
                            controller: _name,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Observer(
                          builder: (_) => TextFormField(
                              onChanged: _createAccountStore.setEmail,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  errorText: _createAccountStore.emailError),
                              keyboardType: TextInputType.emailAddress,
                              controller: _email),
                        ),
                      ),
                      ListTile(
                        title: Observer(
                          builder: (_) => TextFormField(
                              onChanged: _createAccountStore.setPassword,
                              decoration: InputDecoration(
                                  labelText: 'Senha',
                                  errorText: _createAccountStore.passError),
                              obscureText: true,
                              controller: _password),
                        ),
                      ),
                      ListTile(
                        title: Observer(
                          builder: (_) => TextFormField(
                              onChanged: _createAccountStore.setConfirmPassword,
                              decoration: InputDecoration(
                                  labelText: 'Confirme a Senha',
                                  errorText:
                                      _createAccountStore.confirmPassError),
                              obscureText: true,
                              controller: _confirmPass),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Observer(
                        builder: (_) => BottomButton(
                            _createAccountStore.loading,
                            primaryColor,
                            customColor,
                            "Criar Conta",
                            _createAccountStore.createAccountPressed as void
                                Function()?),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Já tenho conta",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String? msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(msg!),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginPage())),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
