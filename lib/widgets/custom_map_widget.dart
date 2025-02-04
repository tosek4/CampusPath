import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  CustomMapWidget({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: MarkerId('examLocation'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: 'Exam Location'),
        ),
      },
    );
  }
}
