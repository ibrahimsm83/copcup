import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/user/user_map_screen/map_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;
  Marker? _marker;
  String? _selectedAddress;

  final String _googleApiKey = 'AIzaSyABvYZeEXmiChqjPm7FPi9s9dxojDHGAek';


  Future<void> _getCurrentLocation() async {
    var status = await Permission.locationWhenInUse.status;
    print("Permission status: $status");

    if (status.isGranted) {
      // ✅ Already granted, proceed
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    } else if (status.isDenied || status.isRestricted) {
      // 🔁 Request permission only once
      var result = await Permission.locationWhenInUse.request();

      if (result.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            14,
          ),
        );
      } else if (result.isPermanentlyDenied) {
        _showLocationSettingsDialog();
      } else {
        showSnackbar(
          message: "Location permission is required.",
          isError: true,
        );
      }
    } else if (status.isPermanentlyDenied) {
      _showLocationSettingsDialog();
    } else {
      showSnackbar(
        message: "Location permission is required.",
        isError: true,
      );
    }
  }

  void _showLocationSettingsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Location Permission Required"),
        content: Text(
          "You've permanently denied location access. Please enable it from app settings.",
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text("Open Settings"),
            onPressed: () {
              openAppSettings();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  // Future<void> _getCurrentLocation() async {
  //   var status = await Permission.locationWhenInUse.request();
  //   print("----permisiion status is $status");
  //   if (status.isGranted) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     _mapController?.animateCamera(
  //       CameraUpdate.newLatLngZoom(
  //           LatLng(position.latitude, position.longitude), 14),
  //     );
  //   } else {
  //     showSnackbar(message: "Location permission is required.", isError: true);
  //   }
  // }

  void _onMapTapped(LatLng position) async {
    setState(() {
      _pickedLocation = position;
      _marker = Marker(
        markerId: MarkerId('selected-location'),
        position: position,
      );
      _selectedAddress = null;
    });

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_googleApiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final address = data['results'][0]['formatted_address'];
        setState(() {
          _selectedAddress = address;
        });
      } else {
        showSnackbar(message: "No address found.", isError: true);
      }
    } else {
      showSnackbar(message: "Failed to fetch address.", isError: true);
    }
  }

  void _onSaveLocation() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    final eventProvider = Provider.of<EventController>(context, listen: false);

    if (_pickedLocation != null && _selectedAddress != null) {
      await MapRepository.getCurrentLocation(
              longitude: _pickedLocation!.longitude.toString(),
              latitude: _pickedLocation!.latitude.toString())
          .then((onValue) async {
        if (onValue) {
          categoryProvider.setSelectedAddress(_selectedAddress!);
          await eventProvider.getUserNearEventList();
          context.pop();
        } else {
          context.pop();

          showSnackbar(message: 'Something went wrong', isError: true);
        }
      });
    } else {
      showSnackbar(
          message: "Please select a location on the map.", isError: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(20.5937, 78.9629), // India
              zoom: 5,
            ),
            onMapCreated: (controller) => _mapController = controller,
            onTap: _onMapTapped,
            markers: _marker != null ? {_marker!} : {},
            myLocationEnabled: true,
          ),
          if (_selectedAddress != null)
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Text(
                  _selectedAddress!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 28.0),
              child: CustomContainer(
                borderRadius: 100,
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                onTap: _onSaveLocation,
                color: colorScheme(context).primary,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: textTheme(context).titleMedium?.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
