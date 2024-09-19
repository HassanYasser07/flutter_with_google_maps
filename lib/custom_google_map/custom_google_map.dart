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

  void initState() {
    super.initState();
    initialCameraPostion = const CameraPosition(
      zoom: 16,
        target: LatLng(31.236096292977177, 29.948132578022626));

  }
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition:initialCameraPostion);
  }
}










// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20