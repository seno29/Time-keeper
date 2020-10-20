import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  RoundButton({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: RaisedButton(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: widget.onPressed),
      ),
    );
  }
}
// Color.fromRGBO(245, 163, 169, 1.0)