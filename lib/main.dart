import 'package:flutter/material.dart';
import 'package:promodromo/models/promodromo/timer_model.dart';
import 'package:promodromo/models/session_model.dart';
import 'package:promodromo/screens/home_screen.dart';
import 'package:promodromo/utils/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promodromo App',
      theme: ThemeData(
          scaffoldBackgroundColor: scafoldColor, fontFamily: "Avenir Next"),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerModel>(
            create: (context) => TimerModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SessionStats(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
