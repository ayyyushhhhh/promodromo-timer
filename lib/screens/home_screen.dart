import 'package:flutter/material.dart';
import 'package:promodromo/models/promodromo/timer_model.dart';
import 'package:promodromo/models/session_model.dart';
import 'package:promodromo/utils/app_colors.dart';
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
    final session = Provider.of<SessionStats>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Promodromo app',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    fillColor: writeUpColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Task : Write an Article ",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  maxLength: 10,
                ),
              ),
              Center(
                child: Consumer<TimerModel>(
                  builder: (context, timerModel, child) {
                    if (timerModel.sessionComplete() == true) {
                      timerModel.startBreak();
                      session.updateSession();
                    } else if (timerModel.isBreakComplete() == true) {
                      timerModel.startSession();
                    }
                    return Column(
                      children: [
                        Text(
                          formatTimer(timerModel.timerDuration),
                          style: TextStyle(fontSize: 60, color: textColor),
                        ),
                        const SizedBox(height: 10),
                        if (timerModel.sessionType == SessionType.workTime)
                          IconButton(
                            iconSize: 60,
                            color: Colors.white,
                            onPressed: () {
                              if (timerModel.isTimerActive() == false) {
                                timerModel.startTimer();
                              } else {
                                timerModel.stopTimer();
                              }
                            },
                            icon: timerModel.isTimerActive()
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                          ),
                        if (timerModel.sessionType == SessionType.breakTime)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 60,
                                color: Colors.white,
                                onPressed: () {
                                  if (timerModel.isTimerActive() == false) {
                                    timerModel.startTimer();
                                  } else {
                                    timerModel.stopTimer();
                                  }
                                },
                                icon: timerModel.isTimerActive()
                                    ? const Icon(Icons.pause)
                                    : const Icon(Icons.play_arrow),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                iconSize: 60,
                                color: Colors.white,
                                onPressed: () {
                                  timerModel.skipSession();
                                },
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
