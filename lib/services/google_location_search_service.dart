import 'package:uuid/uuid.dart';

import 'dart:convert';

import 'package:http/http.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/remote_config_service.dart';

// Taken from:
// https://github.com/yshean/google_places_flutter/blob/master/lib/place_service.dart

class GoogleLocationSearchService {
  final RemoteConfigService? _remoteConfigService =
      locator<RemoteConfigService>();

  final client = Client();
  String _sessionToken = const Uuid().v4();
  String get sessionToken => _sessionToken;

  Future<List<Suggestion>?> fetchSuggestions(String input, String lang) async {
    String _apiKey =
        _remoteConfigService!.getValue(RemoteConfigKey.googlePlaceAPIKey);

    final request = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$_apiKey&sessiontoken=$_sessionToken',
    );
    final response = await client.get(request);

    if (response.statusCode == 200) {
      print('Whoop');
      final result = json.decode(response.body);
      print('Decoded the response');
      if (result['status'] == 'OK') {
        print('Whoop whoop');
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        print('Rip whoop');
        return [];
      }
      print(result);
      print(result['status']);
      throw Exception(result['error_message']);
    } else {
      print('Response not good');
      print('Error');
      print('$response');
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String? placeId) async {
    String _apiKey =
        _remoteConfigService!.getValue(RemoteConfigKey.googlePlaceAPIKey);

    final request = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$_apiKey&sessiontoken=$_sessionToken',
    );
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String? placeId;
  final String? description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
