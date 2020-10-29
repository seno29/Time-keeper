import 'package:flutter/material.dart';

class TaskLabel extends StatefulWidget {
  final String title;
  final String subtitle;
  final DateTime dateCreated;

  TaskLabel({Key key, this.title, this.subtitle, this.dateCreated}) : super(key: key);
  @override
  _TaskLabelState createState() => _TaskLabelState();
}

class _TaskLabelState extends State<TaskLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(  
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 230,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${widget.dateCreated.day}/${widget.dateCreated.month}/${widget.dateCreated.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Text(
              '#${widget.subtitle}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
