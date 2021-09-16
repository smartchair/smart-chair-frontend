import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_chair_frontend/stores/theme_test_store.dart';

class CardSuggestions extends StatelessWidget {
  final ThemeTestStore themeTestStore = GetIt.I<ThemeTestStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 500,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color:
            themeTestStore.isDark ? Colors.grey.shade800 : Colors.grey.shade300,
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
