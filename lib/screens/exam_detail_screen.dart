import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';
import '../widgets/custom_map_widget.dart';
import '../widgets/address_widget.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  ExamDetailScreen({required this.exam});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(exam.dateTime);
    final formattedTime = DateFormat('h:mm a').format(exam.dateTime);

    // Parse coordinates from the location string
    final coords = exam.location.split(',');
    final latitude = double.parse(coords[0].split(':')[1].trim());
    final longitude = double.parse(coords[1].split(':')[1].trim());

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room: ${exam.subject}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Date: $formattedDate',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Time: $formattedTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            AddressWidget(latitude: latitude, longitude: longitude),
            SizedBox(height: 16),
            Expanded(
              child: CustomMapWidget(
                latitude: latitude,
                longitude: longitude,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
