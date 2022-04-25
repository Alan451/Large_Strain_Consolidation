import 'package:flutter/material.dart';
import '../screens/InputScreen1g.dart';
import '../screens/InputScreenNg.dart';


class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Large Strain Consolidation'),
            backgroundColor: const Color(0xff3F80FA),
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( //                         <--- Button
                  child: const Text('1g Consolidation'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      InputScreen1g.id
                    );
                  }
                ),
                ElevatedButton( //                         <--- Button
                    child: const Text('Ng Consolidation'),
                    onPressed: () {
                      Navigator.pushNamed(
                          context,
                          InputScreenNg.id
                      );
                    }
                ),
              ],
            ),
          ),
          ),
    );
  }
}
