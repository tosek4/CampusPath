import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  AddressWidget({required this.latitude, required this.longitude});

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  String _address = 'Fetching address...';

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.latitude,
        widget.longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          _address =
              '${placemark.name}, ${placemark.locality}, ${placemark.country}';
        });
      } else {
        setState(() {
          _address = 'No address found';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Error fetching address';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Location: $_address',
      style: TextStyle(fontSize: 18),
    );
  }
}
