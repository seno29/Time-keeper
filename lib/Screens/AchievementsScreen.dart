import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/Badge.dart';
import 'package:time_keeper/app_icons.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  List<Badge> badges = [];

  void initState() {
    super.initState();
    TaskController.getBadges().then((value) {
      if (value != null) {
        setState(() {
          badges = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarCustom(
          title: 'Achievements',
          leading: Icon(
            MyFlutterApp.trophy,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20),
          child: Text(
            'All Badges',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            child: ListView(children: [
              ...List.generate(
                badges.length,
                (index) => Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    badges[index].desc,
                  ),
                ),
              ),
              SizedBox(height: 80)
            ]),
          ),
        ),
      ]),
    );
  }
}
