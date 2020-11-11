import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/Models/AppStateNotifier.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  bool isDeepFocusModeOn() {
    return Provider.of<AppStateNotifier>(context, listen: false)
        .deepFocusModeOn;
  }

  int getCurrentTheme() {
    return Provider.of<AppStateNotifier>(context, listen: false).themeNumber;
  }

  void updateTheme(int currentTheme) {
    Provider.of<AppStateNotifier>(context, listen: false)
        .updateTheme(currentTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarCustom(
            title: 'Settings',
            leading: Icon(Icons.settings),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deep Focus Mode',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: isDeepFocusModeOn() ,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<AppStateNotifier>(context, listen: false).changeFocusMode();
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose theme :',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    updateTheme(1);
                                  });
                                },
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/theme1.png'),
                                ),
                              ),
                              getCurrentTheme() == 1
                                  ? Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    updateTheme(2);
                                  });
                                },
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/theme2.png'),
                                ),
                              ),
                              getCurrentTheme() == 2
                                  ? Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    updateTheme(3);
                                  });
                                },
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/theme3.png'),
                                ),
                              ),
                              getCurrentTheme() == 3
                                  ? Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    updateTheme(4);
                                  });
                                },
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/theme4.png'),
                                ),
                              ),
                              getCurrentTheme() == 4
                                  ? Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
