class Province {
  String name;
  double latitude;
  double longitude;

  Province(
      {required this.name, required this.latitude, required this.longitude});
}

class ProvinceLatLon {
  static List<Province> provinces = [
    Province(name: 'Hà Nội', latitude: 21.0285, longitude: 105.8542),
    Province(name: 'Hồ Chí Minh', latitude: 10.8231, longitude: 106.6297),
    Province(name: 'Hải Phòng', latitude: 20.8449, longitude: 106.6881),
    Province(name: 'Đà Nẵng', latitude: 16.0544, longitude: 108.2022),
    Province(name: 'Cần Thơ', latitude: 10.0458, longitude: 105.7469),
    Province(name: 'An Giang', latitude: 10.3866, longitude: 105.4358),
    Province(name: 'Bà Rịa - Vũng Tàu', latitude: 10.5449, longitude: 107.1785),
    Province(name: 'Bạc Liêu', latitude: 9.2947, longitude: 105.7242),
    Province(name: 'Bắc Kạn', latitude: 22.1470, longitude: 105.8349),
    Province(name: 'Bắc Giang', latitude: 21.2785, longitude: 106.1947),
    Province(name: 'Bắc Ninh', latitude: 21.1217, longitude: 106.0511),
    Province(name: 'Bến Tre', latitude: 10.2415, longitude: 106.3753),
    Province(name: 'Bình Dương', latitude: 11.1661, longitude: 106.5067),
    Province(name: 'Bình Định', latitude: 13.7878, longitude: 109.2196),
    Province(name: 'Bình Phước', latitude: 11.7500, longitude: 106.6667),
    Province(name: 'Bình Thuận', latitude: 11.0899, longitude: 108.0833),
    Province(name: 'Cà Mau', latitude: 9.1769, longitude: 105.1526),
    Province(name: 'Cao Bằng', latitude: 22.6600, longitude: 106.2500),
    Province(name: 'Đắk Lắk', latitude: 12.6667, longitude: 108.0500),
    Province(name: 'Đắk Nông', latitude: 12.0000, longitude: 107.7500),
    Province(name: 'Điện Biên', latitude: 21.3833, longitude: 103.0167),
    Province(name: 'Đồng Nai', latitude: 10.8790, longitude: 107.1371),
    Province(name: 'Đồng Tháp', latitude: 10.5433, longitude: 105.6375),
    Province(name: 'Gia Lai', latitude: 13.9833, longitude: 108.0000),
    Province(name: 'Hà Giang', latitude: 22.8333, longitude: 104.9833),
    Province(name: 'Hà Nam', latitude: 20.5417, longitude: 105.9228),
    Province(name: 'Hà Tĩnh', latitude: 18.3333, longitude: 105.9000),
    Province(name: 'Hải Dương', latitude: 20.9408, longitude: 106.3331),
    Province(name: 'Hậu Giang', latitude: 9.7833, longitude: 105.4667),
    Province(name: 'Hòa Bình', latitude: 20.8136, longitude: 105.3386),
    Province(name: 'Hưng Yên', latitude: 20.6500, longitude: 106.0500),
    Province(name: 'Khánh Hòa', latitude: 12.2500, longitude: 109.1833),
    Province(name: 'Kiên Giang', latitude: 10.2000, longitude: 105.9500),
    Province(name: 'Kon Tum', latitude: 14.3500, longitude: 108.0000),
    Province(name: 'Lai Châu', latitude: 22.3964, longitude: 103.4582),
    Province(name: 'Lâm Đồng', latitude: 11.9465, longitude: 108.4419),
    Province(name: 'Lạng Sơn', latitude: 21.8530, longitude: 106.7610),
    Province(name: 'Lào Cai', latitude: 22.4833, longitude: 103.9500),
    Province(name: 'Long An', latitude: 10.5410, longitude: 106.4112),
    Province(name: 'Nam Định', latitude: 20.4167, longitude: 106.1667),
    Province(name: 'Nghệ An', latitude: 19.2345, longitude: 104.9200),
    Province(name: 'Ninh Bình', latitude: 20.2527, longitude: 105.9740),
    Province(name: 'Ninh Thuận', latitude: 11.5500, longitude: 108.9833),
    Province(name: 'Phú Thọ', latitude: 21.4000, longitude: 105.2167),
    Province(name: 'Phú Yên', latitude: 13.1000, longitude: 109.3000),
    Province(name: 'Quảng Bình', latitude: 17.5000, longitude: 106.3333),
    Province(name: 'Quảng Nam', latitude: 15.6667, longitude: 108.0000),
    Province(name: 'Quảng Ngãi', latitude: 15.1167, longitude: 108.8000),
    Province(name: 'Quảng Ninh', latitude: 21.0167, longitude: 107.3000),
    Province(name: 'Quảng Trị', latitude: 16.7500, longitude: 107.1500),
    Province(name: 'Sóc Trăng', latitude: 9.6033, longitude: 105.9800),
    Province(name: 'Sơn La', latitude: 21.1667, longitude: 103.9000),
    Province(name: 'Tây Ninh', latitude: 11.3000, longitude: 106.1000),
    Province(name: 'Thái Bình', latitude: 20.4500, longitude: 106.3333),
    Province(name: 'Thái Nguyên', latitude: 21.5958, longitude: 105.8447),
    Province(name: 'Thanh Hóa', latitude: 19.8000, longitude: 105.7667),
    Province(name: 'Thừa Thiên-Huế', latitude: 16.4667, longitude: 107.6000),
    Province(name: 'Tiền Giang', latitude: 10.4080, longitude: 106.3586),
    Province(name: 'Trà Vinh', latitude: 9.9347, longitude: 106.3342),
    Province(name: 'Tuyên Quang', latitude: 21.8233, longitude: 105.2181),
    Province(name: 'Vĩnh Long', latitude: 10.2500, longitude: 105.9667),
    Province(name: 'Vĩnh Phúc', latitude: 21.3089, longitude: 105.6044),
    Province(name: 'Yên Bái', latitude: 21.7000, longitude: 104.8750),
  ];

  static List<Province> getLatLonModel(String location){
    return provinces.where((element) => element.name.contains(location)).toList();
  }
}
