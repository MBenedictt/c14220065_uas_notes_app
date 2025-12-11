import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          appBar: AppBar(title: const Text('Pengaturan')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    ),
                    title: const Text('Mode Gelap'),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
