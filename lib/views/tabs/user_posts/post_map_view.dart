import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/state/posts/providers/location_provider.dart';
import 'package:foraging_buddy/views/components/post/post_map_pin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsMapView extends ConsumerStatefulWidget {
  final Iterable<Post> posts;

  const PostsMapView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsMapViewState();
}

class _PostsMapViewState extends ConsumerState<PostsMapView> {
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  double pinPillPosition = -150;
  late Post currentPost;
//results positions to marker list:

  void initMarker(Post post, String postId) async {
    final MarkerId markerId = MarkerId(postId);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(post.latitude!, post.longitude!),
      infoWindow: InfoWindow(title: post.message),
      onTap: () {
        setState(() {
          pinPillPosition = 0;
          currentPost = post;
        });
      },
    );
    setState(() {
      markers.putIfAbsent(markerId, () => marker);
    });
  }

  Post getFirstPost() {
    return widget.posts.first;
  }

  buildMarkerList() {
    for (var post in widget.posts) {
      initMarker(post, post.postId);
    }
  }

  @override
  initState() {
    super.initState;
    buildMarkerList();
    currentPost = getFirstPost();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = ref.watch(locationProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 8,
      child: currentLocation.when(
        data: (location) {
          return Stack(children: [
            GoogleMap(
                mapType: MapType.hybrid,
                markers: Set<Marker>.of(markers.values),
                initialCameraPosition: CameraPosition(
                    zoom: 10,
                    target: LatLng(location.latitude, location.longitude))),
            PostMapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPost: currentPost,
            ),
          ]);
        },
        error: (Object error, StackTrace stackTrace) {
          return Text(error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
