import 'package:location/location.dart';

class LocationServices{
  Location location =Location();
  Future <bool> checkAndRequestServiceLocation()async {
    var isServiceEnabled =await location.serviceEnabled();
    if(!isServiceEnabled){
      isServiceEnabled= await  location.requestService();
    } if(!isServiceEnabled){
      //   todo: show error bar
    }
    return true;
  }

  Future<bool> checkAndRequestPermissionLocation()async{

    var permissionStatus=await location.hasPermission();
    if(permissionStatus== PermissionStatus.deniedForever){
      return false;
    }
    if(permissionStatus == PermissionStatus.denied){
      permissionStatus= await location.requestPermission();
    }if(permissionStatus != PermissionStatus.granted){
      //    todo: show error bar
    }
    return true;
  }
  void getRealTimeLocationData(void Function(LocationData)?onData){
    location.onLocationChanged.listen(onData);
  }
}