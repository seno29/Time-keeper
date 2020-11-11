import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:provider/provider.dart';
import 'package:time_keeper/CustomWidgets/choose_music_dialog.dart';
import 'package:time_keeper/CustomWidgets/round_button.dart';
import 'package:time_keeper/CustomWidgets/task_label.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_keeper/DBUtility/TaskController.dart';
import 'package:time_keeper/Models/AppStateNotifier.dart';
import 'package:time_keeper/Models/Quotes.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:time_keeper/Models/Timer.dart';

class TimerScreen extends StatefulWidget {
  final int taskid;
  final String taskName;
  final String tagName;
  final DateTime dateCreated;
  final bool active;

  TimerScreen(
      {Key key,
      this.taskid = 0,
      this.taskName = '',
      this.tagName = '',
      this.dateCreated,
      this.active = false})
      : super(key: key);
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with WidgetsBindingObserver {
  int _timeSelected = 5;
  int duration = 25;
  int min = 25;
  int sec = 0;
  String startButtonText = 'Start';
  Timer timer;
  Timer quoteTimer;
  int timeout = 10;
  bool timerActive = false;
  String quoteText = 'Stay Focused';
  bool musicModeOn = false;
  MusicTitle selectedMusic = MusicTitle.none;

  final player = AudioCache();
  AudioPlayer audioPlayer;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void _showtimerNotification(String title, String msg, int id) async {
    await _timerStartedNotification(title, msg, id);
  }

  Future<void> _timerStartedNotification(
      String title, String msg, int id) async {
    var androidTimerStartedChannel = AndroidNotificationDetails(
        'CS', 'timer_started', 'noifications regarding current timer',
        importance: Importance.Max,
        priority: Priority.Max,
        ticker: 'ticker',
        visibility: NotificationVisibility.Public,
        onlyAlertOnce: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidTimerStartedChannel, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, msg, platformChannelSpecifics, payload: 'item x');
  }

  @override
  void initState() {
    super.initState();
    initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (timer != null && quoteTimer != null) {
      timer.cancel();
      quoteTimer.cancel();
    }
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
  }

  void playMusic(MusicTitle musicTitle) async {
    if (musicModeOn) {
      switch (musicTitle) {
        case MusicTitle.lake:
          audioPlayer = await player.loop('lake-waves-trim.mp3');
          break;
        case MusicTitle.rain:
          audioPlayer = await player.loop('rain-trim.mp3');
          break;
        case MusicTitle.river:
          audioPlayer = await player.loop('river_trim.mp3');
          break;
        case MusicTitle.tranquility:
          audioPlayer = await player.loop('Tranquility.mp3');
          break;
        case MusicTitle.runningwater:
          audioPlayer = await player.loop('RunningWatersComp.mp3');
          break;
        default:
      }
    }
  }

  void stopMusic() {
    if (musicModeOn) {
      audioPlayer.stop();
    }
  }

  Future<MusicTitle> chooseMusic() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChooseMusicDialog();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.inactive &&
        isDeepFocusModeOn() &&
        timerActive) {
      timer.cancel();
      quoteTimer.cancel();
      stopMusic();
      resetTimer();
      _showtimerNotification(
          'Timer has stopped', 'You are in deep focus mode!', 0);
    }
  }

  resetTimer() {
    duration = 25;
    min = 25;
    sec = 0;
    timeout = 10;
    quoteText = 'Start Focusing';
    startButtonText = 'Start';
    timerActive = false;
  }

  int getCurrentTheme() {
    return Provider.of<AppStateNotifier>(context, listen: false).themeNumber;
  }

  bool isDeepFocusModeOn() {
    return Provider.of<AppStateNotifier>(context, listen: false)
        .deepFocusModeOn;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (timerActive) {
          bool leave = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Dont give up!'),
                  content: Text('If you went away timer will stop.'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        resetTimer();
                        timer.cancel();
                        quoteTimer.cancel();
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Give Up'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Stay'),
                    ),
                  ],
                );
              });
          return leave;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.dstATop,
              ),
              image: AssetImage('assets/images/back${getCurrentTheme()}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                musicModeOn
                    ? Expanded(
                        child: IconButton(
                          padding: EdgeInsets.all(12),
                          icon: Icon(
                            Icons.queue_music,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (timerActive) {
                              setState(() {
                                stopMusic();
                                musicModeOn = false;
                              });
                            } else {
                              chooseMusic().then((value) {
                                setState(() {
                                  selectedMusic = value;
                                  if (selectedMusic == MusicTitle.none) {
                                    musicModeOn = false;
                                  } else {
                                    musicModeOn = true;
                                  }
                                });
                              });
                            }
                          },
                        ),
                      )
                    : Expanded(
                        child: IconButton(
                          padding: EdgeInsets.all(12),
                          icon: Icon(
                            Icons.volume_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            chooseMusic().then((value) {
                              setState(() {
                                selectedMusic = value;
                                if (selectedMusic == MusicTitle.none) {
                                  musicModeOn = false;
                                } else {
                                  musicModeOn = true;
                                }
                                if (timerActive) {
                                  playMusic(selectedMusic);
                                }
                              });
                            });
                          },
                        ),
                      ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      quoteText,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18),
                    ),
                  ),
                ),
                widget.active
                    ? TaskLabel(
                        title: widget.taskName,
                        subtitle: widget.tagName,
                        dateCreated: widget.dateCreated,
                      )
                    : Container(),
                Expanded(
                  flex: 7,
                  child: Center(
                    child: SingleCircularSlider(
                      24,
                      _timeSelected,
                      selectionColor: Theme.of(context).primaryColor,
                      handlerColor: Theme.of(context).primaryColorDark,
                      baseColor: Color.fromRGBO(255, 255, 255, 0.5),
                      onSelectionChange: (int init, int end, int laps) {
                        if (!timerActive) {
                          setState(() {
                            if (end <= 2) {
                              _timeSelected = 2;
                              min = 10;
                            } else {
                              min = end * 5;
                            }
                            duration = min;
                            // min = 1;
                          });
                        }
                      },
                      width: 250,
                      height: 250,
                      child: Center(
                        child: Text(
                          '${(min < 10) ? '0' + min.toString() : min}:${(sec < 10) ? '0' + sec.toString() : sec}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 70.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: RoundButton(
                      text: startButtonText,
                      onPressed: () {
                        if (startButtonText == 'Start') {
                          timerActive = true;
                          playMusic(selectedMusic);
                          quoteTimer =
                              Timer.periodic(Duration(seconds: 30), (timer) {
                            setState(() {
                              quoteText = Quotes[Random().nextInt(17)];
                            });
                          });
                          timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            _showtimerNotification(
                                'Current Timer',
                                '${(min < 10) ? '0' + min.toString() : min}:${(sec < 10) ? '0' + sec.toString() : sec}',
                                0);
                            setState(() {
                              if (sec == 0 && min == 0) {
                                timeout = 10;
                                timer.cancel();
                                quoteTimer.cancel();
                                startButtonText = 'Start';
                                timerActive = false;
                                flutterLocalNotificationsPlugin.cancel(0);
                                print('Duration: $duration');
                                TaskController.addTimer(
                                  TimerData(
                                      taskid: widget.taskid,
                                      duration: duration,
                                      date: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day)),
                                ).then((value) {
                                  if (value > 0) {
                                    TaskController.updateTaskStatus(
                                            widget.taskid, 'Completed')
                                        .then((value) {
                                      print('timer updated! task updated!');
                                    });
                                  }
                                });
                                _showtimerNotification('Hurray!',
                                    'congratulations...You did it', 1);
                                stopMusic();
                                resetTimer();
                                // reset timer
                              } else {
                                if (sec == 0) {
                                  min--;
                                  sec = 59;
                                } else {
                                  sec--;
                                }
                                if (timeout > 0) {
                                  timeout--;
                                  startButtonText = 'Cancel($timeout)';
                                } else if (timeout == 0) {
                                  startButtonText = 'Give Up';
                                }
                              }
                            });
                          });
                        } else {
                          timerActive = false;
                          stopMusic();
                          setState(() {
                            startButtonText = 'Start';
                            timer.cancel();
                            quoteTimer.cancel();
                            resetTimer();
                          });
                          flutterLocalNotificationsPlugin.cancel(0);
                          _showtimerNotification('Uh Oh!', 'You gave up :(', 1);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'actual duration: $duration',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
