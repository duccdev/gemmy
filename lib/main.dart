import 'package:flutter/material.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/pages/home.dart';
import 'package:gemmy/pages/settings.dart';
import 'package:gemmy/pages/setup.dart';
import 'package:gemmy/widgets/ez/navigationrail.dart';

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
      home: const Scaffold(body: Entry()),
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

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  int _pageIndex = homeIndex;

  Widget _getPage() {
    switch (_pageIndex) {
      case homeIndex:
        return const HomePage();
      case settingsIndex:
        return const SettingsPage();
      default:
        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Globals.apiKey == null) return const SetupPage();
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: EzNavigationRail(
            selectedIndex: _pageIndex,
            onDestinationSelected: (index) =>
                setState(() => _pageIndex = index),
          ),
        ),
        Expanded(child: _getPage()),
      ],
    );
  }
}
