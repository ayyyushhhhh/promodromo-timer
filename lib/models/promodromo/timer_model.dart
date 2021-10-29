import 'dart:async';

import 'package:flutter/material.dart';

enum SessionType { workTime, breakTime }

class TimerModel extends ChangeNotifier {
  Duration _duration = const Duration(seconds: 10);
  Timer? timer;
  SessionType _sessionType = SessionType.workTime;

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

  void startSession() {
    _duration = const Duration(seconds: 10);
    _sessionType = SessionType.workTime;
  }

  void skipSession() {
    if (timer != null && timer!.isActive) {
      _duration = const Duration(seconds: 10);
      _sessionType = SessionType.workTime;
      stopTimer();
      notifyListeners();
    } else if (timer != null && !timer!.isActive) {
      _duration = const Duration(seconds: 10);
      _sessionType = SessionType.workTime;
      stopTimer();
      notifyListeners();
    }
  }

  void startBreak() {
    _duration = const Duration(seconds: 5);
    _sessionType = SessionType.breakTime;
  }

  SessionType get sessionType {
    return _sessionType;
  }

  bool isBreakComplete() {
    if (timer != null) {
      if (timer!.isActive &&
          _duration.inSeconds <= 0 &&
          _sessionType == SessionType.breakTime) {
        stopTimer();
        return true;
      }
    }
    return false;
  }

  bool isTimerActive() {
    if (timer != null) {
      return timer!.isActive;
    }
    return false;
  }

  bool sessionComplete() {
    if (timer != null) {
      if (timer!.isActive &&
          _duration.inSeconds <= 0 &&
          _sessionType == SessionType.workTime) {
        stopTimer();
        return true;
      }
    }
    return false;
  }

  void stopTimer() {
    timer?.cancel();
  }
}
