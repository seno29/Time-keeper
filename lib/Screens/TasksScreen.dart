import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/add_task_dialog.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/CustomWidgets/round_button.dart';
import 'package:time_keeper/CustomWidgets/task_card.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/Task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _completedTaskVisible = false;
  bool taskAdded = false;
  List<Task> pendingTasksList = [];
  List<Task> completedTasksList = [];

  void initState() {
    super.initState();
    refreshTaskList();
    refreshCompletedTaskList();
  }

  void onDeleteTask(int id) async {
    TaskController.deleteTask(id).then((value) {
      if (value >= 1) {
        refreshTaskList();
        refreshCompletedTaskList();
      }
    });
  }

  void refreshTaskList() {
    TaskController.sortPendingTaskByPriority().then((value) {
      setState(() {
        pendingTasksList = value;
      });
    });
  }

  void refreshCompletedTaskList() {
    TaskController.getCompletedTask().then((value) {
      setState(() {
        completedTasksList = value;
      });
    });
  }

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
    // print('called');
    refreshCompletedTaskList();
    refreshTaskList();
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarCustom(
            title: 'Tasks',
            leading: Icon(Icons.assignment),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Pending Tasks',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark, fontSize: 18),
                ),
              ),
              FlatButton(
                onPressed: () {
                  print('Sort pressed!');
                  TaskController.getPendingTask().then((value) {
                    setState(() {
                      if (value != null) {
                        pendingTasksList = value;
                      }
                    });
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Sort by date',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          pendingTasksList.length == 0
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text('No Pending Tasks for now, You are all clear!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                )
              : Container(),
          Expanded(
            flex: 9,
            child: ScrollConfiguration(
              behavior: SplashBehaviour(),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ...List.generate(
                      pendingTasksList.length,
                      (index) => TaskCard(
                            id: pendingTasksList[index].id,
                            title: pendingTasksList[index].title,
                            subtitle: pendingTasksList[index].tag,
                            status: pendingTasksList[index].status,
                            priority: pendingTasksList[index].priority,
                            dateCreated: pendingTasksList[index].dateCreated,
                            onDelete: (id) {
                              onDeleteTask(id);
                            },
                            onEdit: (id) {
                              showDialog<Task>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (_) {
                                    return AddTaskDialog(
                                      title: pendingTasksList[index].title,
                                      tag: pendingTasksList[index].tag,
                                      priority:
                                          pendingTasksList[index].priority,
                                      editMode: true,
                                    );
                                  }).then((task) {
                                if (task != null) {
                                  TaskController.editTask(
                                          pendingTasksList[index].id, task)
                                      .then((value) {
                                    print('edited: $value');
                                    if (value >= 1) {
                                      refreshTaskList();
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Task Edited!'),
                                        duration: Duration(milliseconds: 1000),
                                      ));
                                    } else {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Error in editing task!'),
                                        duration: Duration(milliseconds: 1000),
                                      ));
                                    }
                                  });
                                }
                              });
                            },
                          )),
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
                      children: [
                        ...List.generate(
                          completedTasksList.length,
                          (index) => TaskCard(
                            id: completedTasksList[index].id,
                            title: completedTasksList[index].title,
                            subtitle: completedTasksList[index].tag,
                            status: completedTasksList[index].status,
                            priority: completedTasksList[index].priority,
                            dateCreated: completedTasksList[index].dateCreated,
                            onDelete: (id) {
                              onDeleteTask(id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          RoundButton(
            text: '+ Task',
            onPressed: () {
              _showModelForm().then((task) {
                if (task != null) {
                  TaskController.insertTask(task).then((value) {
                    print('inserted task in pending: $value');
                    if (value >= 1) {
                      refreshTaskList();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Task Added!'),
                        duration: Duration(milliseconds: 1000),
                      ));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Error in adding task!'),
                        duration: Duration(milliseconds: 1000),
                      ));
                    }
                  });
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
