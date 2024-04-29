import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/data_dummy.dart';
import 'package:flutter_google_maps/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  @override
  State<MapsV1Page> createState() => _MapsV1PageState();
}

class _MapsV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer();

  double latitude = -7.2804494;
  double longitude = 112.79447228;

  var mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V1"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
            itemBuilder: (context) {
              return googleMapTypes
                  .map((typeGoogle) => PopupMenuItem(
                        value: typeGoogle.type,
                        child: Text(typeGoogle.type.name),
                      ))
                  .toList();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          _buildGoogleMap(),
        ],
      ),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition:
          CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
      onMapCreated: (controller) => _controller.complete(controller),
      markers: markers,
    );
  }

  void onSelectedMapType(Type value) {
    setState(() {
      switch (value) {
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.Terrain:
          mapType = MapType.terrain;
          break;
        case Type.Satellite:
          mapType = MapType.satellite;
          break;
        default:
      }
    });
  }
}
