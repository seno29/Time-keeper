import 'package:time_keeper/Models/Badge.dart';

Badge type1 = Badge(
    imagePath: 'assets/images/200B.png',
    desc: 'Focus Milestone 200 minutes!',
    lock: true);

Badge type2 = Badge(
    imagePath: 'assets/images/500B.png',
    desc: 'Focus Milestone 500 minutes!',
    lock: true);

Badge type3 = Badge(
    imagePath: 'assets/images/10hB.png',
    desc: 'Focus Milestone 10 hours!',
    lock: true);

Badge type4 = Badge(
    imagePath: 'assets/images/1000B.png',
    desc: 'Focus Milestone 1000 minutes!',
    lock: true);

class BadgeMap {
  static Map<int, Badge> badgeMap = {
    200: type1,
    500: type2,
    600: type3,
    1000: type4
  };
}
