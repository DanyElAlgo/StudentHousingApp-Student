import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:housing_design_system/housing_design_system.dart';

class RoomLocationMap extends StatelessWidget {
  const RoomLocationMap({
    super.key,
    required this.latitude,
    required this.longitude,
    this.height = 220,
  });

  final double latitude;
  final double longitude;
  final double height;

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(latitude, longitude);

    return ClipRRect(
      borderRadius: AppRadii.lg,
      child: SizedBox(
        height: height,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: position, zoom: 15),
          markers: {
            Marker(markerId: const MarkerId('room'), position: position),
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          liteModeEnabled: false,
        ),
      ),
    );
  }
}
