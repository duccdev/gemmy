import 'package:flutter/material.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/pages/home.dart';
import 'package:gemmy/pages/settings.dart';
import 'package:gemmy/pages/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Globals.init();
  runApp(const Gemmy());
}

class Gemmy extends StatelessWidget {
  const Gemmy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemmy',
      initialRoute: '/entry',
      onGenerateRoute: (settings) {
        const Map<String, Widget> routes = {
          '/entry': Entry(),
          '/home': HomePage(),
          '/settings': SettingsPage(),
        };

        return !routes.containsKey(settings.name)
            ? null
            : PageRouteBuilder(
                pageBuilder: (_, __, ___) => Scaffold(
                  body: routes[settings.name]!,
                ),
              );
      },
      theme: ThemeData(
        fontFamily: 'NotoSans',
        scaffoldBackgroundColor: const Color(0xFF131314),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Color(0xFF498BD5),
        ),
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          radius: const Radius.circular(6),
          thumbColor: WidgetStateProperty.all(const Color(0xFF858585)),
          thickness: WidgetStateProperty.all(12),
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Color(0xFF1E1F20),
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          indicatorColor: Colors.white,
        ),
      ),
    );
  }
}

class Entry extends StatelessWidget {
  const Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return Globals.apiKey != null ? const HomePage() : const SetupPage();
  }
}
