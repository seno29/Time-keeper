import 'package:flutter/material.dart';
import 'package:time_keeper/app_icons.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final onTap;
  BottomNavBar({Key key, this.selectedIndex, this.onTap}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  double _iconSize = 25;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.selectedIndex;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 16,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(1, 1),
              blurRadius: 3,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.onTap(0);
                },
                child: Icon(
                  Icons.format_list_bulleted,
                  size: _iconSize,
                  color: _selectedIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey[350],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.onTap(1);
                },
                child: Icon(
                  Icons.timeline,
                  size: _iconSize,
                  color: _selectedIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey[350],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.onTap(2);
                },
                child: Icon(
                  MyFlutterApp.trophy,
                  size: 20,
                  color: _selectedIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey[350],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.onTap(3);
                },
                child: Icon(
                  Icons.settings,
                  size: _iconSize,
                  color: _selectedIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey[350],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
