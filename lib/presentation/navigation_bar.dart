import 'package:flutter/material.dart';
import 'package:park_manager/utils/gm_colors.dart';
import 'garage/garage_screen.dart';
import 'history/history_screen.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: PMColor.lightBlue,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: PMColor.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.car_crash),
            icon: Icon(Icons.garage),
            label: 'Garagem',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Histórico',
          )
        ],
      ),
      body: <Widget>[
        const GarageScreen(title: 'Park Manager',),
        const HistoryScreen(title: 'Histórico',),
      ][currentPageIndex],
    );
  }
}
