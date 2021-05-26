import 'package:flutter/material.dart';

class CardGamification extends StatelessWidget {
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
                "100",
                style: TextStyle(fontSize: 70),
              ),
              Text("Bom trabalho")
            ],
          ),
        ),
      ),
    );
  }
}
