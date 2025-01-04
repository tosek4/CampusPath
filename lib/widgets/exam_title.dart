import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamTile extends StatelessWidget {
  final Exam exam;

  const ExamTile({required this.exam});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exam.subject),
      subtitle: Text('${exam.dateTime} at ${exam.location}'),
    );
  }
}
