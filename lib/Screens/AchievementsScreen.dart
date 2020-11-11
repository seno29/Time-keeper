import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/CustomWidgets/badge_card.dart';
import 'package:time_keeper/DBUtility/BadgeController.dart';
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
    BadgeController.getBadges().then((value) {
      setState(() {
        if (value != null) {
          badges = value;
        }
      });
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
            'Your Badges',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            child: ListView(
              children: [
                ...List.generate(
                  badges.length,
                  (index) => BadgeCard(
                    desc: badges[index].desc,
                    imagePath: badges[index].imagePath,
                    lock: badges[index].lock
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
