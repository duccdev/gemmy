import 'package:flutter/material.dart';
import 'package:gemmy/widgets/ez/text.dart';

const homeIndex = 0;
const settingsIndex = 1;

class EzNavigationRail extends StatelessWidget {
  const EzNavigationRail({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      groupAlignment: -1,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (index) {
        switch (index) {
          case homeIndex:
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case settingsIndex:
            Navigator.of(context).pushReplacementNamed('/settings');
            break;
        }
      },
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: EzText('Home', fontSize: 14),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: EzText('Settings', fontSize: 14),
        ),
      ],
    );
  }
}
