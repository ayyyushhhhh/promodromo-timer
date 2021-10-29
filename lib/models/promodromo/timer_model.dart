import 'dart:async';

import 'package:flutter/material.dart';

enum SessionType { workTime, breakTime }

class TimerModel extends ChangeNotifier {
  Duration _duration = const Duration(seconds: 10);
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_duration.inSeconds > 0) {
          _duration = _duration - const Duration(seconds: 1);
          notifyListeners();
        } else {
          _duration = _duration - const Duration(seconds: 0);
          stopTimer();
        }
      },
    );
  }

  Duration get timerDuration {
    return _duration;
  }

  void startBreak() {
    _duration = const Duration(minutes: 5);
    notifyListeners();
  }

  bool isTimerActive() {
    if (timer != null) {
      notifyListeners();
      return timer!.isActive;
    }
    return false;
  }

  bool sessionComplete() {
    if (timer != null) {
      if (timer!.isActive && _duration.inSeconds <= 0) {
        stopTimer();
        return true;
      }
    }
    return false;
  }

  void stopTimer() {
    timer?.cancel();
    notifyListeners();
  }
}
