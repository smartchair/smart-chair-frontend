import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/errorBoxWidget/error_box.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/stores/forgot_pass_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final ForgotPassStore forgotPassStore = ForgotPassStore();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();

    when((_) => forgotPassStore.result == 'Senha atualizada com sucesso', () {
      _showAlertDialog(context, forgotPassStore.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 150),
          Observer(
            builder: (_) => Padding(
              padding: EdgeInsets.all(8),
              child: ErrorBox(
                message: forgotPassStore.error,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Observer(
                builder: (_) => TextFormField(
                  onChanged: forgotPassStore.setEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: forgotPassStore.emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Observer(
                builder: (_) => TextFormField(
                  onChanged: forgotPassStore.setPassword,
                  decoration: InputDecoration(
                    labelText: 'Nova senha',
                    errorText: forgotPassStore.passError,
                  ),
                  obscureText: true,
                  controller: _password,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Observer(
                builder: (_) => TextFormField(
                  onChanged: forgotPassStore.setConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirme a senha',
                    errorText: forgotPassStore.confirmPassError,
                  ),
                  obscureText: true,
                  controller: _confirmPass,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Observer(
              builder: (_) => BottomButton(
                  forgotPassStore.loading,
                  primaryColor,
                  customColor,
                  "Redefinir Senha",
                  forgotPassStore.resetPasswordPressed as void Function()?),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Voltar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ]),
          ),
        ]),
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
