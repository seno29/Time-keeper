import 'package:flutter/material.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Screens/TimerScreen.dart';

class TaskCard extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final String status;
  final int priority;
  final DateTime dateCreated;
  final void Function(int) onDelete;
  final void Function(int) onEdit;
  TaskCard(
      {Key key,
      this.id,
      this.title,
      this.subtitle,
      this.status,
      this.priority,
      this.dateCreated,
      this.onDelete,
      this.onEdit})
      : super(key: key);
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  int completionTime = 0;

  void initState() {
    super.initState();
    if (widget.status == 'Completed') {
      TaskController.getTaskCompletionDuration(widget.id).then((value) {
        setState(() {
          completionTime = value;
        });
      });
    }
  }

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
        padding: EdgeInsets.only(bottom: 8, top: 10, right: 5.0),
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
                            taskid: widget.id,
                            taskName: widget.title,
                            tagName: widget.subtitle,
                            dateCreated: widget.dateCreated,
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
                      color: Colors.lightGreen,
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
                      '${widget.dateCreated.day}/${widget.dateCreated.month}/${widget.dateCreated.year}',
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
                      width: widget.status == 'Pending' ? 170 : 150,
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
                                color: Colors.lightBlue[300],
                                size: 20,
                              ),
                              onPressed: () {
                                widget.onEdit(widget.id);
                              },
                            ),
                          )
                        : Container(
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top:5.0, right: 5.0),
                                child: Icon(
                                  Icons.timer,
                                  size: 15,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text('$completionTime', style: TextStyle(color: Colors.lightGreen),),
                              )
                            ]),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                          size: 20,
                        ),
                        onPressed: () {
                          widget.onDelete(widget.id);
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
