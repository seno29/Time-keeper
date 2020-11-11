class Badge{
  String desc;
  bool lock;
  String imagePath;
  Badge({this.desc,  this.imagePath, this.lock=true});

  void unLockBadge(){
    this.lock = false;
  }
}