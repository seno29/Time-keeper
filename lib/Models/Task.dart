class Task{
  int id;
  String title;
  String tag;
  String status;
  int priority;
  DateTime dateCreated;

  Task({this.id, this.title, this.tag, this.status, this.priority, this.dateCreated});
  
  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'tag': tag,
      'status': status,
      'priority': priority,
      'date': dateCreated.toIso8601String()
    };
  }
}