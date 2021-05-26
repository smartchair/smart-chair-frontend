import 'package:flutter/material.dart';

class CardSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 500,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey.shade300,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Você está bem",
                style: TextStyle(fontSize: 30),
              ),
              Text("Já foi ao parque hoje?")
            ],
          ),
        ),
      ),
    );
  }
}
