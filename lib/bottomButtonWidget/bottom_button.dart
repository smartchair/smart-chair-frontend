import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final bool loading;
  final Color textColor;
  final Color backgroundColor;
  final String buttonText;
  final VoidCallback? callback;

  BottomButton(this.loading, this.textColor, this.backgroundColor,
      this.buttonText, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(textColor),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return backgroundColor.withOpacity(0.6);
              } else {
                return backgroundColor;
              }
            }),
            //backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
      ),
    );
  }
}
