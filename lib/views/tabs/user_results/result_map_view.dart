import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/state/posts/providers/location_provider.dart';
import 'package:foraging_buddy/views/components/result/result_map_pin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultsMapView extends ConsumerStatefulWidget {
  final Iterable<Result> results;

  const ResultsMapView({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultsMapViewState();
}

class _ResultsMapViewState extends ConsumerState<ResultsMapView> {
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  double pinPillPosition = -150;
  late Result currentResult;
//results positions to marker list:

  void initMarker(Result result, String resultId) async {
    final MarkerId markerId = MarkerId(resultId);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(result.latitude!, result.longitude!),
      infoWindow: InfoWindow(title: result.title),
      onTap: () {
        setState(() {
          pinPillPosition = 0;
          currentResult = result;
        });
      },
    );
    setState(() {
      markers.putIfAbsent(markerId, () => marker);
    });
  }

  Result getFirstResult() {
    return widget.results.first;
  }

  buildMarkerList() {
    for (var result in widget.results) {
      initMarker(result, result.resultId);
    }
  }

  @override
  initState() {
    super.initState;
    buildMarkerList();
    currentResult = getFirstResult();
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
            ResultMapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedResult: currentResult,
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
