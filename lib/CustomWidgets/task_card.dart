import 'package:flutter/material.dart';
import 'package:time_keeper/Screens/TimerScreen.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String status;
  final int priority;

  TaskCard({Key key, this.title, this.subtitle, this.status, this.priority})
      : super(key: key);
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Color getIconColor() {
    if (widget.priority == 2) {
      return Colors.red;
    } else if (widget.priority == 1) {
      return Colors.orange;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 10.0, top: 5, right: 5.0),
        child: Row(
          children: [
            widget.status == 'Pending'
                ? IconButton(
                    icon: Icon(Icons.play_circle_filled, color: getIconColor()),
                    onPressed: () {
                      print(widget.title);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(
                            taskName: widget.title,
                            tagName: widget.subtitle,
                            active: true,
                          ),
                        ),
                      );
                    },
                  )
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                      Icons.check_circle,
                      color: Colors.green[300],
                    ),
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 185,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'yesterday',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 170,
                      child: Text(
                        '#${widget.subtitle}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    widget.status == 'Pending'
                        ? Container(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                // color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                print('task edit');
                              },
                            ),
                          )
                        : Container(child: Text('25')),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          // color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          print('task deleted');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}