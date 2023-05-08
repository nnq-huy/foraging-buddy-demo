import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/views/components/post/post_map_pin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SinglePostMapView extends StatelessWidget {
  final Post post;
  const SinglePostMapView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {};

    markers.add(Marker(
      markerId: MarkerId(post.userId),
      position: LatLng(post.latitude!, post.longitude!), //position of marker
      infoWindow: InfoWindow(title: post.message),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.message,
        ),
      ),
      body: Stack(children: [
        GoogleMap(
            mapType: MapType.satellite,
            markers: markers,
            initialCameraPosition: CameraPosition(
                zoom: 16, target: LatLng(post.latitude!, post.longitude!))),
        PostMapPinPillComponent(
          pinPillPosition: 0,
          currentlySelectedPost: post,
        ),
      ]),
    );
  }
}
