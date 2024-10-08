import 'package:flutter_with_google_maps/utils/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../models/place_model.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  @override
  late LocationServices locationServices;
  late CameraPosition initialCameraPostion;
   GoogleMapController? googleMapController;

  void initState() {
    super.initState();
     locationServices =LocationServices();
    updateMyLocation();
    initMarkers();
    initPolyline();
    initPolygons();
    initCircles();
    initialCameraPostion = const CameraPosition(
        zoom: 16,
        target: LatLng(31.236096292977177, 29.948132578022626));
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};

  Widget build(BuildContext context) {
    return GoogleMap(
      circles: circles,
      polygons: polygons,
      polylines: polylines,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
        initMapStyle();

      },
      initialCameraPosition: initialCameraPostion,
      // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
      //     southwest: const LatLng(31.080569617326795, 29.763491041232577),
      //     northeast: const LatLng(31.30846738149212, 30.169298507189573))),


    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/sunney_map_style.json');
    googleMapController!.setMapStyle(nightMapStyle);
  }

  void initMarkers() {
    var myPlaces = places
        .map((placeMarker) =>
        Marker(
          infoWindow: InfoWindow(title: placeMarker.name),
          position: placeMarker.latLng,
          markerId: MarkerId(placeMarker.id.toString()),
        ))
        .toSet();

    markers.addAll(myPlaces);
  }

  void initPolyline() {
    Polyline polyline = const Polyline(polylineId: PolylineId('1'), points: [
      LatLng(31.226208780435154, 29.960687255469185),
      LatLng(31.225364720875195, 29.954593276341214),
      LatLng(31.231750027730584, 29.955365752568703),
      LatLng(31.236593765802407, 29.95060214916585),
    ]);
    polylines.add(polyline);
  }

  void initPolygons() {
    Polygon polygon = Polygon(polygonId: PolygonId('1'), points: [
      LatLng(31.226208780435154, 29.960687255469185),
      LatLng(31.225364720875195, 29.954593276341214),
      LatLng(31.231750027730584, 29.955365752568703),
    ]);
    polygons.add(polygon);
  }


  void initCircles() {
    Circle myLocation = Circle(
        circleId: CircleId('1'),
        center: LatLng(31.22892439918011, 29.96030101735544),
        radius: 5000,
        fillColor: Colors.white.withOpacity(.5));
    circles.add(myLocation);
  }



  // void getLocationData(){
  //   location.changeSettings(
  //     distanceFilter: 2
  //   );
  //   location.onLocationChanged.listen(
  //           (locationData){
  //     var cameraPosition= CameraPosition(
  //         zoom: 8,
  //         target:LatLng(locationData.latitude!, locationData.longitude!) );
  //     var myLocationMarker= Marker(
  //         position: LatLng(locationData.latitude!, locationData.longitude!),
  //         markerId: MarkerId('2'));
  //     markers.add(myLocationMarker);
  //     setState(() {
  //
  //     });
  //     googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   });
  //
  // }
  void updateMyLocation()async{
    locationServices.checkAndRequestServiceLocation();
  var hasPermission=await locationServices.checkAndRequestPermissionLocation();
  if( hasPermission){
    locationServices.getRealTimeLocationData((locationData){
      setMyCameraPosition(locationData);
    });
  }else{
    
  }

  }

  void setMyCameraPosition(LocationData locationData) {
    var cameraPosition= CameraPosition(
        target:LatLng(locationData.latitude!, locationData.longitude!) );
    setMyLocationMarkSpace(locationData);
    googleMapController?.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));
  }

  void setMyLocationMarkSpace(LocationData locationData) {
    var myLocationMarker= Marker(
        position: LatLng(locationData.latitude!, locationData.longitude!),
        markerId: MarkerId('2'));
    markers.add(myLocationMarker);
    setState(() {

    });
  }

}







// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20