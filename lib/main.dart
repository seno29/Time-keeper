import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/app_theme.dart';
import 'package:time_keeper/Models/AppStateNotifier.dart';
import 'package:time_keeper/Screens/AchievementsScreen.dart';
import 'package:time_keeper/Screens/AnalyticsScreen.dart';
import 'package:time_keeper/Screens/SettingsScreen.dart';
import 'package:time_keeper/Screens/TasksScreen.dart';
import 'CustomWidgets/floating_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  ThemeData getTheme(int themeNumber) {
    switch (themeNumber) {
      case 1:
        return AppTheme.theme1;
        break;

      case 2:
        return AppTheme.theme2;
        break;

      case 3:
        return AppTheme.theme3;
        break;

      case 4:
        return AppTheme.theme4;
        break;

      default:
        return ThemeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: getTheme(appState.themeNumber),
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _screens = [
    TasksScreen(),
    AnalyticsScreen(),
    AchievementScreen(),
    SettingsScreen()
  ];
  int selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[selectedIndex],
          Positioned(
            bottom: 10,
            child: BottomNavBar(
              selectedIndex: selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
