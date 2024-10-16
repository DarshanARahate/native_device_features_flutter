import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_device_features_flutter/providers/user_places.dart';
import 'package:native_device_features_flutter/screens/add_places.dart';
import 'package:native_device_features_flutter/widgets/places_list.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Place'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
