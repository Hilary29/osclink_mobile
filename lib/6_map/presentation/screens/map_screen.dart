import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(51.509865, -0.118092), // initial point
          initialZoom: 10.0,
        ),
        children: [
          TileLayer(
            //standard OpenStreetMap tile server URL
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.osclink_mobile',
          ),
          //TODO other layers here
        ],
      ),
    );
  }
}
