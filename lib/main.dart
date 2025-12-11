import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'app_theme.dart';
import 'notes_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Theming App',

            theme: AppTheme.getLightTheme(themeProvider.fontFamily),
            darkTheme: AppTheme.getDarkTheme(themeProvider.fontFamily),

            themeMode: themeProvider.themeMode,
            home: const NotesPage(),
          );
        },
      ),
    );
  }
}
