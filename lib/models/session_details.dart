class SessionModel {
  Duration? focusTime = const Duration(minutes: 25);
  Duration? shortBreak = const Duration(minutes: 5);
  Duration? longBreak = const Duration(minutes: 30);
  int? intervals = 4;

  SessionModel(
      {this.focusTime, this.shortBreak, this.longBreak, this.intervals});

  SessionModel updateSession(
      {Duration? focusTime,
      Duration? shortBreak,
      Duration? longBreak,
      int? intervals}) {
    return SessionModel(
      focusTime: focusTime ?? this.focusTime,
      shortBreak: shortBreak ?? this.shortBreak,
      longBreak: longBreak ?? this.longBreak,
      intervals: intervals ?? this.intervals,
    );
  }
}
