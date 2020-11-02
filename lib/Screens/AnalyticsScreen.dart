import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/BarChartData.dart';
import 'package:time_keeper/Models/DoughnutChartData.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int totalDuration = 0;
  int totalPendingTasks = 0;
  int totalCompletedTasks = 0;
  int todaysTotalCompletedTasks = 0;
  int todaysTotalFocusTime = 0;
  List<DoughnutChartData> chartData = [];
  List<BarChartData> barChartData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskController.getTotalFocusTime().then((value) {
      if (value != null) {
        setState(() {
          totalDuration = value;
        });
      }
    });
    TaskController.getTotalPendingTask().then((value) {
      if (value != null) {
        setState(() {
          totalPendingTasks = value;
        });
      }
    });
    TaskController.getTotalCompletedTask().then((value) {
      if (value != null) {
        setState(() {
          totalCompletedTasks = value;
        });
      }
    });
    TaskController.getChartData().then((value) {
      if (value != null) {
        setState(() {
          chartData = value;
        });
      }
    });
    TaskController.getBarChartData().then((value) {
      if (value != null) {
        setState(() {
          barChartData = value;
        });
      }
    });
    TaskController.getTotalTodaysCompletedTask().then((value) {
      if (value != null) {
        setState(() {
          todaysTotalCompletedTasks = value;
        });
      }
    });
    TaskController.getTodaysTotalFocusTime().then((value) {
      if (value != null) {
        setState(() {
          todaysTotalFocusTime = value;
        });
      }
    });
  }

  void send() async {
    final Email email = Email(
      body: 'Total Focus Time: $todaysTotalFocusTime min\nTotal Pending Task: $totalPendingTasks\nTotal Completed Task: $totalCompletedTasks',
      subject: 'Today\'s Report',
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
    print(platformResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          AppBarCustom(
            title: 'Analytics',
            leading: Icon(Icons.insert_chart),
          ),
          Expanded(
            flex: 9,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 50,
                                    width: 85,
                                    child: Text(
                                      'Total Focus Time',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${(totalDuration / 60).toStringAsFixed(1)} h',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 0,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 50,
                                    width: 85,
                                    child: Text(
                                      'Total Task Completed',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '$totalCompletedTasks',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 0,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 50,
                                    width: 85,
                                    child: Text(
                                      'Total Task Pending',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '$totalPendingTasks',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: Text('Below is Your Daily Stats'),
                        ),
                        FlatButton(
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail_outline,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 3),
                              Text('Report')
                            ],
                          ),
                          onPressed: () {
                            send();
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 85,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('Today\'s Progress')),
                          Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 20,
                              value: todaysTotalCompletedTasks == 0 &&
                                      totalPendingTasks == 0
                                  ? 0
                                  : todaysTotalCompletedTasks /
                                      (todaysTotalCompletedTasks +
                                          totalPendingTasks),
                              backgroundColor: Colors.grey[400],
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$todaysTotalCompletedTasks/${todaysTotalCompletedTasks + totalPendingTasks} Tasks Completed',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Your day at a glance: ',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          chartData.length == 0
                              ? Text('No data available')
                              : Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: 300,
                                  child: Center(
                                    child: SfCircularChart(
                                      legend: Legend(
                                          isVisible: true,
                                          position: LegendPosition.bottom,
                                          overflowMode:
                                              LegendItemOverflowMode.wrap,
                                          itemPadding: 10,
                                          iconBorderWidth: 0,
                                          padding: 3),
                                      series: <CircularSeries>[
                                        // Renders doughnut chart
                                        DoughnutSeries<DoughnutChartData,
                                            String>(
                                          dataSource: chartData,
                                          // pointColorMapper:(DoughnutChartData data,  _) => data.color,
                                          xValueMapper:
                                              (DoughnutChartData data, _) =>
                                                  data.tag,
                                          yValueMapper:
                                              (DoughnutChartData data, _) =>
                                                  data.duration,
                                          dataLabelMapper:
                                              (DoughnutChartData data, _) =>
                                                  data.duration.toString() +
                                                  ' min',
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            textStyle: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Today\'s Total Focus time(in min): $todaysTotalFocusTime',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Current month at a glance: ',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          barChartData.length == 0
                              ? Text('No data For bar chart')
                              : Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: 300,
                                  child: SfCartesianChart(
                                    primaryXAxis: NumericAxis(
                                        title: AxisTitle(text: 'Date'),
                                        minimum: 1,
                                        maximum: 31,
                                        interval: 1),
                                    primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                          text: 'Total Focus Duration(in min)'),
                                    ),
                                    series: <ChartSeries>[
                                      // Renders column chart
                                      ColumnSeries<BarChartData, double>(
                                          dataSource: barChartData,
                                          xValueMapper:
                                              (BarChartData data, _) =>
                                                  data.date.toDouble(),
                                          yValueMapper:
                                              (BarChartData data, _) =>
                                                  data.duration)
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Expanded(
//             flex: 2,
//             child: Container(
//               padding: EdgeInsets.only(top: 10),
//               margin: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 50,
//                             width: 85,
//                             child: Text(
//                               'Total Focus Time',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.deepPurple,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             '${(totalDuration / 60).toStringAsFixed(1)} h',
//                             style: TextStyle(
//                               color: Colors.deepPurple,
//                               fontSize: 28,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 0,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey[400]),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 50,
//                             width: 85,
//                             child: Text(
//                               'Total Task Completed',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.green,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             '$totalCompletedTasks',
//                             style: TextStyle(
//                               color: Colors.green,
//                               fontSize: 28,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 0,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey[400]),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 50,
//                             width: 85,
//                             child: Text(
//                               'Total Task Pending',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             '$totalPendingTasks',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 28,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Container(
//               margin: EdgeInsets.all(10.0),
//               width: double.infinity,
//               height: 300,
//               // color: Colors.grey[300],
//               child: Center(
//                 child: SfCircularChart(
//                   legend: Legend(
//                       isVisible: true,
//                       position: LegendPosition.bottom,
//                       overflowMode: LegendItemOverflowMode.wrap,
//                       itemPadding: 10,
//                       iconBorderWidth: 0,
//                       padding: 3),
//                   series: <CircularSeries>[
//                     // Renders doughnut chart
//                     DoughnutSeries<DoughnutChartData, String>(
//                       dataSource: chartData,
//                       // pointColorMapper:(DoughnutChartData data,  _) => data.color,
//                       xValueMapper: (DoughnutChartData data, _) => data.tag,
//                       yValueMapper: (DoughnutChartData data, _) => data.duration,
//                       dataLabelMapper: (DoughnutChartData data, _) =>
//                           data.duration.toString()+' min',
//                       dataLabelSettings: DataLabelSettings(
//                         isVisible: true,
//                         textStyle: TextStyle(
//                           fontSize: 8,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Container(
//               margin: EdgeInsets.all(10.0),
//               width: double.infinity,
//               height: 300,
//               color: Colors.grey[300],
//               child: Center(child: Text('Grpahs')),
//             ),
//           )
