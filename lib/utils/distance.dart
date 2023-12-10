import 'package:app_dubaothoitiet/utils/province.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class CalculateDistance {
  static Province getTheClosestDistanceLocationProvince(Position value){
    Province minDistanceProvince = ProvinceLatLon.provinces.first;
    double minDistanceCalculate = 1000;
    for(var item in ProvinceLatLon.provinces){
      double tempDistanceCalculate = math.sqrt(math.pow((value.latitude-item.latitude), 2)+math.pow((value.longitude-item.longitude), 2));
      if(tempDistanceCalculate < minDistanceCalculate){
        minDistanceCalculate = tempDistanceCalculate;
        minDistanceProvince = item;
        print(tempDistanceCalculate.toString());
      }
    }
    return minDistanceProvince;
  }
}