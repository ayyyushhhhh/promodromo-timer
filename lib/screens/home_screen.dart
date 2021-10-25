import 'package:flutter/material.dart';
import 'package:promodromo/blocs/timer_bloc.dart';
import 'package:promodromo/models/session_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String formatTimer(Duration durationTimer) {
    final String minute =
        durationTimer.inMinutes.remainder(60).toString().padLeft(2, "0");
    final String seconds =
        durationTimer.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minute:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final timerBloc = Provider.of<WorkTimerBloc>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            'Focus',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 30),
          Center(
            child: StreamBuilder<Duration>(
              stream: timerBloc.timerStream,
              builder:
                  (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                if (snapshot.hasData) {
                  final Duration? timerDuration = snapshot.data;
                  if (timerBloc.sessionComplete() == true) {
                    final session =
                        Provider.of<SessionModel>(context, listen: false);
                    session.increaseNumSessions();
                    timerBloc.startBreak();
                  }
                  return Text(
                    formatTimer(timerDuration as Duration),
                    style: Theme.of(context).textTheme.headline2,
                  );
                } else {
                  return Text(
                    formatTimer(timerBloc.duration),
                    style: Theme.of(context).textTheme.headline2,
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          IconButton(
            iconSize: 60,
            onPressed: () {
              if (timerBloc.isActive() == false) {
                timerBloc.startTimer();
              } else {
                timerBloc.stopTimer();
              }
            },
            icon: timerBloc.isActive()
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
