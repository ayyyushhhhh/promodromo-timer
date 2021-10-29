import 'package:flutter/material.dart';

class SessionStats extends ChangeNotifier {
  int _numSessions = 0;

  void updateSession() {
    _numSessions = _numSessions + 1;
  }

  int get getNumSessions => _numSessions;
}
