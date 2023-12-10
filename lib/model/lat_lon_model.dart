
class LatLonModel {
  double lat;
  double lon;

  LatLonModel({
    required this.lat,
    required this.lon,
  });

  factory LatLonModel.fromJson(Map<String, dynamic> json) => LatLonModel(
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}
