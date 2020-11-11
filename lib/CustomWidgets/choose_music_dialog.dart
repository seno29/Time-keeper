import 'package:flutter/material.dart';

class ChooseMusicDialog extends StatefulWidget {
  @override
  _ChooseMusicDialogState createState() => _ChooseMusicDialogState();
}

enum MusicTitle { none, tranquility, rain, river, lake, runningwater }

class _ChooseMusicDialogState extends State<ChooseMusicDialog> {
  MusicTitle selectedMusic = MusicTitle.none;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Choose Music:',
        style: TextStyle(color: Colors.black),
      ),
      content: Container(
        height: 350,
        child: Column(children: [
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.none,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'None',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.tranquility,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'Tranquility',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.rain,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'Rain',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.river,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'River',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.lake,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'Lake Waves',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: MusicTitle.runningwater,
              groupValue: selectedMusic,
              onChanged: (value) {
                setState(() {
                  selectedMusic = value;
                });
              },
            ),
            title: Text(
              'Symphony',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            print('Selected music: $selectedMusic');
            Navigator.of(context).pop(selectedMusic);
          },
          child: Text(
            'DONE',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
