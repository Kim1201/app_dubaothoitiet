import 'package:app_dubaothoitiet/model/weather_data_current.dart';
import 'package:app_dubaothoitiet/model/weather_data_daily.dart';
import 'package:app_dubaothoitiet/model/weather_data_hourly.dart';



class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataDaily? hourly;
  final WeatherDataHourly? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  // function to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => daily!;
  WeatherDataDaily getDailyWeather() => hourly!;
}
