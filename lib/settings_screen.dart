import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'path_to_theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: Provider.of<ThemeNotifier>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
