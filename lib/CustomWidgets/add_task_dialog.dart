import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/round_button.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/Tag.dart';
import 'package:time_keeper/Models/Task.dart';

class AddTaskDialog extends StatefulWidget {
  final String title;
  final String tag;
  final int priority;
  final bool editMode;
  AddTaskDialog(
      {Key key,
      this.title = '',
      this.tag = 'Work',
      this.priority = 2,
      this.editMode = false})
      : super(key: key);
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String priorityValue;
  String tagValue;

  List<Tag> tagList = [];

  TextEditingController tagController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  void initState() {
    super.initState();
    setState(() {
      taskTitleController.text = widget.title;
      tagValue = widget.tag;
      if (widget.priority == 2) {
        priorityValue = 'High';
      } else if (widget.priority == 1) {
        priorityValue = 'Medium';
      } else {
        priorityValue = 'Low';
      }
    });
    refreshTagList();
  }

  void refreshTagList() {
    TaskController.getTags().then((tags) {
      setState(() {
        tagList = tags;
      });
    });
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    tagController.dispose();
    super.dispose();
  }

  Future<int> _showAddTagDialog() async {
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            height: 185,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Add Custom Tag',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Text('Tag name: '),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: tagController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundButton(
                      text: 'Add',
                      onPressed: () {
                        TaskController.insertTag(Tag(name: tagController.text)).then((value) {
                          // print('inserted tag: $value');
                          Navigator.of(context).pop(value);
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Enter Task Details',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Text(
                  'Task title: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: taskTitleController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  ),
                ),
                Text(
                  'Select tag: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: tagValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      tagValue = newValue;
                    });
                  },
                  items: tagList.map<DropdownMenuItem<String>>((Tag tag) {
                    return DropdownMenuItem<String>(
                      value: tag.name,
                      child: Text(tag.name),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        print('add tag');
                        _showAddTagDialog().then((value) {
                          if(value > 0){
                            refreshTagList();
                          }
                        });
                      },
                      child: Text(
                        '+ custom tag',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Select priority: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: priorityValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      priorityValue = newValue;
                    });
                  },
                  items: <String>['High', 'Medium', 'Low']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundButton(
                      text: widget.editMode ? 'Save' : 'Add',
                      onPressed: () {
                        if (taskTitleController.text != '') {
                          int priority = 0;
                          if (priorityValue == 'High') {
                            priority = 2;
                          } else if (priorityValue == 'Medium') {
                            priority = 1;
                          } else {
                            priority = 0;
                          }
                          Navigator.of(context).pop(
                            Task(
                              title: taskTitleController.text,
                              tag: tagValue,
                              status: 'Pending',
                              priority: priority,
                              dateCreated: DateTime.now()
                            ),
                          );
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter task title!'),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
