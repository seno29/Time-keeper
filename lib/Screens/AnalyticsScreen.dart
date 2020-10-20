import 'package:flutter/material.dart';
import 'package:time_keeper/CustomWidgets/app_bar.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      child: Column(
        children: [
          AppBarCustom(title: 'Analytics',leading: Icon(Icons.insert_chart),),
          Expanded(
            flex: 2,
            child: Container(
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
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '15.0 h',
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
                            '12',
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
                            '18',
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
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: Center(child: Text('Graphs')),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: Center(child: Text('Grpahs')),
            ),
          )
        ],
      ),
    );
  }
}
