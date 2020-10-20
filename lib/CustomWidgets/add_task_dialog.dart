import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/round_button.dart';
import 'package:time_keeper/Models/Task.dart';

class AddTaskDialog extends StatefulWidget {
  final List<String> tagList;
  AddTaskDialog({Key key, this.tagList}) : super(key: key);
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String priorityValue = 'High';
  String tagValue = 'Work';
  bool taskAdded = false;

  List<String> tagList = [
    'Work',
    'Study',
    'Sports',
    'Assignment',
    'Mediatation'
  ];

  TextEditingController tagController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();

  @override
  void dispose() {
    taskTitleController.dispose();
    tagController.dispose();
    super.dispose();
  }

  Future<void> _showAddTagDialog() async {
    return showDialog<void>(
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
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
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
                        setState(() {
                          tagList.add(tagController.text);
                        });
                        Navigator.of(context).pop();
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
            height: 300,
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: taskTitleController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                  items: tagList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        print('add tag');
                        _showAddTagDialog();
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                      text: 'Add',
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
