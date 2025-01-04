import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

import 'exam_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final exams = ExamRepository().exams;

    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Calendar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_exam')
                  .then((_) => setState(() {}));
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(context, '/map');
            },
          ),
        ],
      ),
      body: exams.isEmpty
          ? Center(child: Text('No exams scheduled.'))
          : ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final exam = exams[index];
                final formattedDate =
                    DateFormat('EEEE, MMM d, yyyy').format(exam.dateTime);
                final formattedTime =
                    DateFormat('h:mm a').format(exam.dateTime);

                return ListTile(
                  title: Text('Subject: ${exam.title}\nRoom: ${exam.subject}'),
                  subtitle: Text(
                      '$formattedDate at $formattedTime\nLocation: ${exam.locationName}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        ExamRepository().removeExam(exam);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamDetailScreen(exam: exam),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
