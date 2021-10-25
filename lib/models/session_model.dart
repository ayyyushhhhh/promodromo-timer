import 'package:flutter/material.dart';

class SessionModel extends ChangeNotifier {
  final int _numSessions = 0;

  int increaseNumSessions() {
    return _numSessions + 1;
  }

  int get getNumSessions => _numSessions;
}
