import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; 
import '../models/exam.dart';
import 'map_screen.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _subject = '';
  String _location = '';
  String _locationName = ''; 
  DateTime? _dateTime;
  LatLng? _selectedLocation;

  Future<void> _fetchLocationName(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      setState(() {
        _locationName = placemarks.isNotEmpty
            ? '${placemarks.first.name}, ${placemarks.first.locality}'
            : 'Unknown Location';
      });
    } catch (e) {
      setState(() {
        _locationName = 'Error fetching location name';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject'),
                onSaved: (value) => _subject = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a subject' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (selectedTime != null) {
                      setState(() {
                        _dateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
                child: Text(_dateTime == null
                    ? 'Select Date and Time'
                    : '${_dateTime!.toLocal()}'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final LatLng? location = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  );

                  if (location != null) {
                    setState(() {
                      _selectedLocation = location;
                      _location =
                          'Lat: ${location.latitude}, Lng: ${location.longitude}';
                    });
                    await _fetchLocationName(location);
                  }
                },
                child: Text(_selectedLocation == null
                    ? 'Select Location'
                    : 'Location Selected: $_locationName'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _dateTime != null) {
                    _formKey.currentState!.save();
                    ExamRepository().addExam(
                      Exam(
                        title: _title,
                        subject: _subject,
                        location: _location,
                        locationName: _locationName.isEmpty
                            ? 'No location specified'
                            : _locationName,
                        dateTime: _dateTime!,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please complete all required fields'),
                      ),
                    );
                  }
                },
                child: Text('Save Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
