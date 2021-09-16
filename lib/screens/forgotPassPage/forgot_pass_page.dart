import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/errorBoxWidget/error_box.dart';
import 'package:smart_chair_frontend/responsiveLayoutWidget/responsive_layout_widget.dart';
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

  late FocusNode focusNodeInputEmail;
  late FocusNode focusNodeInputSenha;
  late FocusNode focusNodeInputConfirmeSenha;

  @override
  void initState() {
    super.initState();

    focusNodeInputEmail = new FocusNode();
    focusNodeInputSenha = new FocusNode();
    focusNodeInputConfirmeSenha = new FocusNode();

    when((_) => forgotPassStore.result == 'Senha atualizada com sucesso', () {
      _showAlertDialog(context, forgotPassStore.result);
    });
  }

  void setFocusInputConfirmeSenha() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeInputConfirmeSenha);
    });
  }

  void setFocusInputEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeInputEmail);
    });
  }

  void setFocusInputSenha() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeInputSenha);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      tiny: Container(),
      tablet: Container(),
      largeTablet: Container(),
      computer: Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: customColor),
                          ),
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
                Observer(
                  builder: (_) => BottomButton(
                      forgotPassStore.loading,
                      primaryColor,
                      customColor,
                      "Redefinir Senha",
                      forgotPassStore.resetPasswordPressed as void Function()?),
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              "Voltar",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
      phone: Scaffold(
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
                    focusNode: focusNodeInputEmail,
                    onTap: () => setFocusInputEmail(),
                    onChanged: forgotPassStore.setEmail,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: customColor,
                        ),
                      ),
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
                    focusNode: focusNodeInputSenha,
                    onTap: () => setFocusInputSenha(),
                    onChanged: forgotPassStore.setPassword,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: customColor),
                      ),
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
                    focusNode: focusNodeInputConfirmeSenha,
                    onTap: () => setFocusInputConfirmeSenha(),
                    onChanged: forgotPassStore.setConfirmPassword,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: customColor),
                      ),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Voltar",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
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
