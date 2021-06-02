import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:smart_chair_frontend/http/user_controller.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
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

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    rootBundle.load('assets/loading_tcc.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_controller = SimpleAnimation('Animation 1'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  Future<String> loadingTime() async {
    return Future.delayed(Duration(seconds: 5))
        .then((value) => 'Loading is done!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: loadingTime(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Stack(alignment: Alignment.center, children: [
              //BackgroundWidget(),
              Container(
                width: 85,
                height: 85,
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(
                        artboard: _riveArtboard,
                      ),
              ),
            ]),
          );
        } else {
          return Stack(
            children: <Widget>[
              //BackgroundWidget(),
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
                          ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(labelText: 'Nome'),
                              controller: _name,
                              validator: (val) {
                                if (val.isEmpty)
                                  return "O nome não pode ser vazio";
                                return null;
                              },
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              validator: (val) {
                                if (val.isEmpty || !val.contains("@"))
                                  return "O Email não é valido";
                                return null;
                              },
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(labelText: 'Senha'),
                              obscureText: true,
                              controller: _password,
                              validator: (val) {
                                if (val.isEmpty)
                                  return "A senha não pode ser vazia";
                                return null;
                              },
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Confirme a Senha'),
                              obscureText: true,
                              controller: _confirmPass,
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'A senha não pode ser vazia';
                                if (val != _password.text)
                                  return 'As senhas não coincidem';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BottomButton(primaryColor, customColor, "Criar Conta",
                              () {
                            validatePass();
                          }),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
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
          );
        }
      },
    ));
  }

  void validatePass() async {
    List<String> list = ['1', '2'];
    String msg;
    if (_form.currentState.validate()) {
      User user = new User();
      user.email = _email.text;
      user.password = _password.text;
      user.chairs = list;

      print(user.chairs);

      msg = await createUser(user);
      if (msg == HttpStatus.created.toString()) {
        Navigator.pop(context);
      } else {
        _showAlertDialog(context, msg);
      }
    }
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

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('As senhas são diferentes'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
