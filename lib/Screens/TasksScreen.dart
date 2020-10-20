import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/add_task_dialog.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/CustomWidgets/round_button.dart';
import 'package:time_keeper/CustomWidgets/task_card.dart';
import 'package:time_keeper/Models/Task.dart';
import 'package:time_keeper/Screens/TimerScreen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _completedTaskVisible = false;
  bool taskAdded = false;
  List<TaskCard> pendingTasks = [
    TaskCard(
      title: 'some pending task huj hv hhgh hg h long long desc ription',
      subtitle: 'tag',
      status: 'Pending',
      priority: 2,
    ),
    TaskCard(
      title: 'some pending task',
      subtitle: 'tag',
      status: 'Pending',
      priority: 0,
    ),
    TaskCard(
      title: 'some pending task',
      subtitle: 'tag',
      status: 'Pending',
      priority: 1,
    ),
    TaskCard(
      title: 'some pending task',
      subtitle: 'tag',
      status: 'Pending',
      priority: 2,
    )
  ];
  List<TaskCard> completedTasks = [
    TaskCard(
      title: 'some completed task huj hv hhgh hg h long long desc ription',
      subtitle: 'tag',
      status: 'Completed',
      priority: 2,
    ),
    TaskCard(
      title: 'some completed task',
      subtitle: 'tag',
      status: 'Completed',
      priority: 0,
    ),
    TaskCard(
      title: 'some completed task',
      subtitle: 'tag',
      status: 'Completed',
      priority: 1,
    ),
    TaskCard(
      title: 'some completed task',
      subtitle: 'tag',
      status: 'Completed',
      priority: 2,
    )
  ];

  Future<Task> _showModelForm() async {
    return showDialog<Task>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (_) {
          return AddTaskDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarCustom(
            title: 'Tasks',
            leading: Icon(Icons.assignment),
          ),
          Expanded(
            flex: 9,
            child: ScrollConfiguration(
              behavior: SplashBehaviour(),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Pending Tasks',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18),
                    ),
                  ),
                  ...pendingTasks,
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _completedTaskVisible = !_completedTaskVisible;
                        });
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _completedTaskVisible
                                    ? 'Hide Completed Tasks'
                                    : 'Show Completed Tasks',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                              Icon(
                                _completedTaskVisible
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _completedTaskVisible,
                    child: Column(
                      children: [...completedTasks],
                    ),
                  ),
                ],
              ),
            ),
          ),
          RoundButton(
            text: '+ Task',
            onPressed: () {
              _showModelForm().then((value) {
                if (value != null) {
                  setState(() {
                    pendingTasks.add(TaskCard(
                      title: value.title,
                      subtitle: value.tag,
                      status: 'Pending',
                      priority: value.priority,
                    ));
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Task Added!'),
                  ));
                }
              });
            },
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}

class SplashBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
