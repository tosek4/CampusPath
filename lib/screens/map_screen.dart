import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          if (_selectedLocation != null)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(41.9981, 21.4254),
          zoom: 10,
        ),
        onTap: (LatLng position) {
          setState(() {
            _selectedLocation = position;
          });
        },
        markers: _selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selected'),
                  position: _selectedLocation!,
                )
              }
            : {},
      ),
    );
  }
}
