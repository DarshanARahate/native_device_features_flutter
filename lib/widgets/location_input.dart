import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_device_features_flutter/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/locations/root_location_entity.dart';

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation location) onSelectLocation;

  LocationInput({super.key, required this.onSelectLocation});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBTQSgIH5YAGCP1znGoPQ5YdF5KoQBet8c';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=geojson&lat=21.143723717869776&lon=79.11208885055439');

    final response = await http.get(url);
    final resData = json.decode(response.body);
    print(response);
    final address = LocationBody.fromJson(resData);

    print("displayName : " + address.features![0].properties!.displayName!);

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: lat,
          longitude: lng,
          address: address.features![0].properties!.displayName!);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(context) {
    Widget previewContent = Text(
      'No location chose',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Text(
        _pickedLocation!.address,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      );
      // previewContent = Image.network(
      //   locationImage,
      //   fit: BoxFit.cover,
      //   width: double.infinity,
      //   height: double.infinity,
      // );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            // TextButton.icon(
            //   onPressed: () {},
            //   icon: const Icon(Icons.map),
            //   label: const Text('Select on Map'),
            // ),
          ],
        ),
      ],
    );
  }
}
