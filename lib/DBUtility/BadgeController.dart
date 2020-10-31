import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/Badge.dart';
import 'package:time_keeper/Models/BadgesMap.dart';

class BadgeController{
  static Future<List<Badge>> getBadges() async{
    int totalFocusTime = await TaskController.getTotalFocusTime();
    Map<int, Badge> badgeMap = BadgeMap.badgeMap;
    List<Badge> badgeList = [];
    for(int key in badgeMap.keys){
      if(totalFocusTime >= key){
        badgeMap[key].unLockBadge();     
      }
      badgeList.add(badgeMap[key]);
    }
    return badgeList;
  }  
}