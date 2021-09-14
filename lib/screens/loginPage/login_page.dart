import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/bottomNavigationBarMenu/bottom_navigation_bar_menu.dart';
import 'package:smart_chair_frontend/errorBoxWidget/error_box.dart';
import 'package:smart_chair_frontend/responsiveLayoutWidget/responsive_layout_widget.dart';
import 'package:smart_chair_frontend/screens/createAccountPage/create_account_page.dart';
import 'package:smart_chair_frontend/screens/forgotPassPage/forgot_pass_page.dart';
import 'package:smart_chair_frontend/screens/offlinePage/offline_page.dart';
import 'package:smart_chair_frontend/stores/connectivity_store.dart';
import 'package:smart_chair_frontend/stores/login_store.dart';
import 'package:smart_chair_frontend/stores/theme_test_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore? userManagerStore = GetIt.I<UserManagerStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  final ThemeTestStore themeTestStore = GetIt.I<ThemeTestStore>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late FocusNode focusNodeInputEmail;
  late FocusNode focusNodeInputSenha;

  var disposeAutoRun;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNodeInputEmail = FocusNode();
    // focusNodeInput1.addListener(() =>
    //     print('focusNode updated: hasFocus: ${focusNodeInput1.hasFocus}'));

    focusNodeInputSenha = FocusNode();
    // focusNodeInput2.addListener(() =>
    //     print('focusNode updated: hasFocus: ${focusNodeInput2.hasFocus}'));

    Future.delayed(Duration(seconds: 2), () {
      disposeAutoRun = autorun((_) {
        if (!connectivityStore.isConnected) {
          print(connectivityStore.isConnected);
          Future.delayed(Duration(microseconds: 50)).then((value) {
            showDialog(context: context, builder: (_) => OfflinePage());
          });
        }
      });
    });

    when((_) => userManagerStore!.user != null, () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationBarMenu()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    focusNodeInputEmail.dispose();
    focusNodeInputSenha.dispose();

    disposeAutoRun();
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
    return Scaffold(
      body: ResponsiveLayout(
        tiny: Container(),
        tablet: Container(),
        largeTablet: Container(),
        computer: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
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
                                labelText: 'Email',
                                errorText: loginStore.emailError),
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
                                labelText: 'Senha',
                                errorText: loginStore.passError),
                            controller: passwordController),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassPage()));
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
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
                  ),
                  Observer(
                    builder: (_) => Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: BottomButton(
                          loginStore.loading,
                          primaryColor,
                          customColor,
                          "Entrar",
                          loginStore.logInPressed as void Function()?),
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
                                      builder: (context) =>
                                          CreateAccountPage()));
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "Cadastre-se",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        phone: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 3,
                        child:
                            Image(image: AssetImage('assets/SmartChair.png'))),
                    SizedBox(height: 10),
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
                              focusNode: focusNodeInputEmail,
                              onTap: () => setFocusInputEmail(),
                              onChanged: loginStore.setEmail,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: customColor),
                                  ),
                                  labelText: 'Email',
                                  errorText: loginStore.emailError),
                              controller: nameController),
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
                              onChanged: loginStore.setPass,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: customColor),
                                  ),
                                  labelText: 'Senha',
                                  errorText: loginStore.passError),
                              controller: passwordController),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassPage()));
                          },
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
                        child: BottomButton(
                            loginStore.loading,
                            primaryColor,
                            customColor,
                            "Entrar",
                            loginStore.logInPressed as void Function()?),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.forbidden,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Não tem conta? "),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountPage()));
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
