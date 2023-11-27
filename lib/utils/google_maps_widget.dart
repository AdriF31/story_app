import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget(
      {super.key,
      required this.lat,
      required this.lon,
      this.scrollGestureEnabled = true,
      required this.gMapsController,
      required this.markers});

  final double? lat;
  final double? lon;
  final Set<Marker>? markers;
  final bool? scrollGestureEnabled;
  final Completer<GoogleMapController>? gMapsController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          gMapsController!.complete(controller);
        },
        mapType: MapType.normal,
        scrollGesturesEnabled: scrollGestureEnabled!,
        markers: markers!,
        initialCameraPosition: CameraPosition(
            target: LatLng(
              lat!,
              lon!,
            ),
            zoom: 15));
  }
}
