import 'package:flutter/material.dart';
import 'package:promodromo/blocs/timer_bloc.dart';
import 'package:promodromo/models/session_model.dart';
import 'package:promodromo/screens/home_screen.dart';
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
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.black45,
      ),
      home: MultiProvider(
        providers: [
          Provider<WorkTimerBloc>(
            create: (context) => WorkTimerBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => SessionModel(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
