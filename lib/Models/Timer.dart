class TimerData{
  int id;
  int taskid;
  int duration;
  DateTime date;

  TimerData({this.id, this.taskid, this.duration, this.date});

  Map<String, dynamic> toMap(){
    return {
      'taskid': taskid,
      'duration': duration,
      'date': date.toIso8601String()
    };
  }
}