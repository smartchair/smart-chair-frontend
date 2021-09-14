import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:smart_chair_frontend/stores/theme_test_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final UserManagerStore? userManagerStore = GetIt.I<UserManagerStore>();
  final ThemeTestStore themeTestStore = GetIt.I<ThemeTestStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Tema',
                leading: Icon(Icons.brightness_low),
                onPressed: (context) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Observer(
                        builder: (_) => Container(
                          height: 200,
                          child: Center(
                            child: ListView(
                              children: [
                                CheckboxListTile(
                                  title: Text('Automático'),
                                  value: themeTestStore.isThemeAutomatic,
                                  onChanged: (value) {
                                    themeTestStore.setAutomaticTheme(value!);
                                    themeTestStore.setDarkTheme(false);
                                    themeTestStore.setLightTheme(false);
                                  },
                                ),
                                Divider(),
                                CheckboxListTile(
                                    title: Text('Escuro'),
                                    value: themeTestStore.isDark,
                                    onChanged: (value) {
                                      themeTestStore.setDarkTheme(value!);
                                      themeTestStore.setAutomaticTheme(false);
                                      themeTestStore.setLightTheme(false);
                                    }),
                                Divider(),
                                CheckboxListTile(
                                    title: Text('Claro'),
                                    value: themeTestStore.isLight,
                                    onChanged: (value) {
                                      themeTestStore.setLightTheme(value!);
                                      themeTestStore.setAutomaticTheme(false);
                                      themeTestStore.setDarkTheme(false);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SettingsTile(
                title: 'Sair',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) {
                  userManagerStore!.logout();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
