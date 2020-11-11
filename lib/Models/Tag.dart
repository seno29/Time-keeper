class Tag{
  int id;
  String name;
  Tag({this.id, this.name});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
    };
  }
}