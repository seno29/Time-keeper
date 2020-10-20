import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_keeper/Models/AppStateNotifier.dart';
import 'package:time_keeper/Screens/TimerScreen.dart';

class AppBarCustom extends StatefulWidget {
  final String title;
  final Icon leading;
  AppBarCustom({Key key, this.title, this.leading}) : super(key: key);
  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {

  int getCurrentTheme() {
    return Provider.of<AppStateNotifier>(context, listen: false).themeNumber;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      flexibleSpace: Image(
        image: AssetImage('assets/images/appbar${getCurrentTheme()}.jpg'),
        fit: BoxFit.fitWidth,
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 18),
          icon: Icon(Icons.timer),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TimerScreen(active: false)),
            );
            print('Open timer screen');
          },
        ),
      ],
      backgroundColor: Colors.transparent,
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
