import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/stores/forgot_pass_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final ForgotPassStore forgotPassStore = ForgotPassStore();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    when((_) => forgotPassStore.result == 'Email enviado com sucesso', () {
      _showAlertDialog(context, forgotPassStore.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(
                builder: (_) => TextFormField(
                  onChanged: forgotPassStore.setEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: forgotPassStore.emailError,
                  ),
                  controller: nameController,
                ),
              ),
              SizedBox(height: 20),
              BottomButton(
                  forgotPassStore.loading,
                  primaryColor,
                  customColor,
                  "Enviar Email",
                  forgotPassStore.sendEmailPressed as void Function()?),
              SizedBox(
                height: 30,
              ),
              Container(
                child: GestureDetector(
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
              ),
              // Container(
              //   width: 150,
              //   child: BottomButton(
              //     false,
              //     primaryColor,
              //     customColor,
              //     "Voltar",
              //     () => Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => LoginPage()),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
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
