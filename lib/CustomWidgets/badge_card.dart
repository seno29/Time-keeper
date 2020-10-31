import 'package:flutter/material.dart';

class BadgeCard extends StatefulWidget {
  final String desc;
  final String imagePath;
  final bool lock;
  BadgeCard({this.desc, this.imagePath, this.lock});
  @override
  _BadgeCardState createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: widget.lock
                ? Image.asset('assets/images/badgeLocked.png')
                : Image.asset(widget.imagePath),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
                widget.desc,
                style: TextStyle(
                  decoration:  widget.lock? TextDecoration.lineThrough: null,
                  color: widget.lock? Colors.grey :Colors.pink[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
