import 'package:flutter/material.dart';
 
class AppStateNotifier extends ChangeNotifier {
  int themeNumber = 2;
  bool deepFocusModeOn = true;
  
  void updateTheme(int theme) {
    this.themeNumber = theme;
    notifyListeners();
  }

  void changeFocusMode(){
    deepFocusModeOn = !deepFocusModeOn;
  }
}