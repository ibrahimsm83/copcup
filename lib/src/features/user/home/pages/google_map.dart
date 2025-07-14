import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/location_controller.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    // Fetch the user's location from the LocationController
    _getUserLocation();
  }

  // Fetching the user's location using LocationController
  Future<void> _getUserLocation() async {
    // Using Provider to access the LocationController
    final locationController =
        Provider.of<LocationController>(context, listen: false);

    // Make sure the location is fetched first
    await locationController.getCurrentLocation();

    // If location is successfully fetched, use it to update the map
    if (locationController.location != 'Fetching location...' &&
        locationController.location != 'Error fetching location') {
      // Assuming LocationController's location provides a string with coordinates
      final coordinates = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentLocation = LatLng(coordinates.latitude, coordinates.longitude);
      });

      // Move the camera to the user's location once fetched
      _moveCameraToUserLocation();

      // Optionally, you can also post the location to the server (already done in LocationController)
      await locationController.getCurrentLocation();
    } else {
      // Handle any error messages from LocationController here
      print('Location fetch error: ${locationController.location}');
    }
  }

  // Move the map camera to the user's current location
  Future<void> _moveCameraToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(currentLocation),
    );
  }

  // Return location to the previous screen
  void _returnLocationToHome() {
    Navigator.pop(
      context,
      {
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        backgroundColor: Colors.blue,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.8,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation ??
                      LatLng(37.42796133580664, -122.085749655962),
                  zoom: 12,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: MarkerId('userLocation'),
                    position: currentLocation,
                    infoWindow: InfoWindow(title: 'Your Location'),
                  ),
                },
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: _returnLocationToHome,
                child: Text(AppLocalizations.of(context)!.na_selectLocation),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
