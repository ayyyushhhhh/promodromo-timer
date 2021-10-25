import 'dart:async';

class WorkTimerBloc {
  Timer? timer;
  Duration duration = const Duration(seconds: 10);
  final StreamController<Duration> _timerController =
      StreamController<Duration>();

  Stream<Duration> get timerStream => _timerController.stream;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (duration.inSeconds > 0) {
          _timerController.sink.add(duration);
          duration = duration - const Duration(seconds: 1);
        } else {
          _timerController.sink.add(const Duration(seconds: 0));
          stopTimer();
        }
      },
    );
  }

  void startBreak() {
    duration = const Duration(minutes: 5);
    _timerController.sink.add(duration);
    stopTimer();
  }

  bool sessionComplete() {
    if (timer != null) {
      if (timer!.isActive && duration.inSeconds <= 0) {
        return true;
      }
    }
    return false;
  }

  bool isActive() {
    if (timer == null) {
      return false;
    } else {
      if (timer!.isActive) {
        return true;
      } else {
        return false;
      }
    }
  }

  void stopTimer() {
    timer?.cancel();
  }
}
