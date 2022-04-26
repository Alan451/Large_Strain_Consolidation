import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static String id = 'error_screen';
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, String>{}) as Map;
    final message = arguments['message'];
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Error!!'),
            backgroundColor: const Color(0xff3F80FA),
            elevation: 0,
          ),
          body: Center(
            child: Text('$message'),
          ),
        )
    );
  }
}
