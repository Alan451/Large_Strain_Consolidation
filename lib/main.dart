import 'package:flutter/material.dart';
import 'package:long_strain_consolidation/screens/HomeScreen.dart';
import 'screens/ResultScreen1g.dart';
import 'screens/InputScreen1g.dart';
import 'screens/InputScreenNg.dart';
import 'screens/ResultScreenNg.dart';
import 'screens/ErrorScreen.dart';
// this is the root of our application
void main() async {
  runApp(const MyApp());
}

// MyApp is used to store all routes and takes the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          InputScreen1g.id: (context) => const InputScreen1g(),
          ResultScreen1g.id: (context) => const ResultScreen1g(),
          InputScreenNg.id: (context) => const InputScreenNg(),
          ResultScreenNg.id: (context) => const ResultScreenNg(),
          ErrorScreen.id: (context) => const ErrorScreen(),
        });
  }
}