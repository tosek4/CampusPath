import 'package:http/http.dart' as http;

class GoogleMapsService {
  final String apiKey = 'YOUR_API_KEY';

  Future<String> fetchRoute(String origin, String destination) async {
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body; 
    } else {
      throw Exception('Failed to fetch directions');
    }
  }
}
