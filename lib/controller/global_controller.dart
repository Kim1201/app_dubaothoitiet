import 'package:app_dubaothoitiet/utils/distance.dart';
import 'package:app_dubaothoitiet/utils/province.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:app_dubaothoitiet/api/fetch_weather.dart';
import 'package:app_dubaothoitiet/model/weather_data.dart';

class GlobalController extends GetxController {
  // create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxString _currentCityName = ''.obs;
  Province _currentProvince = ProvinceLatLon.provinces.first;

  // instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  RxString getCityName() => _currentCityName;
  Province getCurrentProvince() => _currentProvince;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    // getting the current-position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // update our latitude and longitude
      var minDistanceProvince = CalculateDistance.getTheClosestDistanceLocationProvince(value);
      _currentProvince = minDistanceProvince;
      _currentCityName.value = minDistanceProvince.name;
      _lattitude.value = minDistanceProvince.latitude;
      _longitude.value = minDistanceProvince.longitude;
      // calling our weather api
      return FetchWeatherAPI()
          .processData(value.latitude.toString(), value.longitude.toString())
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  refreshWeatherData(Province province){
    FetchWeatherAPI()
        .processData(province.latitude.toString(), province.longitude.toString())
        .then((value) {
      weatherData.value = value;
      _currentProvince = province;
      _currentCityName.value = province.name;
      _lattitude.value = province.latitude;
      _longitude.value = province.longitude;
      _isLoading.value = false;
    });
  }


  RxInt getIndex() {
    return _currentIndex;
  }
}
