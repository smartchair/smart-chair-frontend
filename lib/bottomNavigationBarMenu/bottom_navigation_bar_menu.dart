import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:smart_chair_frontend/screens/homePage/home_page.dart';
import 'package:smart_chair_frontend/screens/introPage/intro_page.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class BottomNavigationBarMenu extends StatefulWidget {
  @override
  _BottomNavigationBarMenuState createState() =>
      _BottomNavigationBarMenuState();
}

class _BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 2: Mood',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    SettingsList(
      sections: [
        SettingsSection(
          title: 'FELIPE',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: 'Use fingerprint',
              leading: Icon(Icons.fingerprint),
              switchValue: true,
              onToggle: (bool value) {},
            ),
          ],
        ),
      ],
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq), label: 'Gráficos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.tag_faces_rounded), label: 'Mood'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: customColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
