import 'package:flutter/material.dart';
import 'screens/calendar_screen.dart';
import 'screens/add_exam_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Scheduler',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => CalendarScreen(),
        '/add_exam': (context) => AddExamScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
