import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButtonUtil {
  SizedBox buildBottomButton(
      Color textColor,
      Color backgroundColor,
      double bottomPadding,
      Alignment pageAlignment,
      String buttonText,
      double buttonFactor,
      VoidCallback callback) {
    return new SizedBox(
      child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Align(
            alignment: pageAlignment,
            child: ElevatedButton(
              onPressed: callback,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(textColor),
                  backgroundColor: MaterialStateProperty.all(backgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)))),
              child: FractionallySizedBox(
                widthFactor: buttonFactor,
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
