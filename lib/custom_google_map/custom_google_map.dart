import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  @override
  late CameraPosition initialCameraPostion;
  late GoogleMapController googleMapController;

  void initState() {
    super.initState();
    initMarkers();
    initialCameraPostion = const CameraPosition(
      zoom: 16,
        target: LatLng(31.236096292977177, 29.948132578022626));

  }
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
     Set<Marker> markers={};
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      onMapCreated: (controller){
        googleMapController = controller;
        initMapStyle();

      },
      initialCameraPosition:initialCameraPostion,
      cameraTargetBounds: CameraTargetBounds(LatLngBounds(
          southwest: const LatLng(31.080569617326795, 29.763491041232577),
          northeast: const LatLng(31.30846738149212, 30.169298507189573))),



    );
  }
  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/sunney_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }
  void initMarkers() {
    var myMarker = const Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.187084851056554, 29.928110526889437));
    markers.add(myMarker);
  }
}










// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20