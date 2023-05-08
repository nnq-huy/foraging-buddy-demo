import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/views/components/result/result_map_pin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleResultMapView extends StatelessWidget {
  final Result result;
  const SingleResultMapView({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {};

    markers.add(Marker(
      markerId: MarkerId(result.userId),
      position:
          LatLng(result.latitude!, result.longitude!), //position of marker
      infoWindow: InfoWindow(title: result.title),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          result.title,
        ),
      ),
      body: Stack(children: [
        GoogleMap(
            mapType: MapType.satellite,
            markers: markers,
            initialCameraPosition: CameraPosition(
                zoom: 16, target: LatLng(result.latitude!, result.longitude!))),
        ResultMapPinPillComponent(
          pinPillPosition: 0,
          currentlySelectedResult: result,
        ),
      ]),
    );
  }
}
