import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key key}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
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
              SettingsTile(
                title: 'Sair',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) {
                  userManagerStore.logout();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
