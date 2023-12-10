import 'package:app_dubaothoitiet/controller/global_controller.dart';
import 'package:app_dubaothoitiet/screens/home_screen.dart';
import 'package:app_dubaothoitiet/utils/province.dart';
import 'package:app_dubaothoitiet/widgets/current_weather_widget.dart';
import 'package:app_dubaothoitiet/widgets/daily_data_forecast.dart';
import 'package:app_dubaothoitiet/widgets/header_collapsed_widget.dart';
import 'package:app_dubaothoitiet/widgets/hourly_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.latlonModel});

  Province latlonModel;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();

  double zoomValue = 15;

  final GlobalController globalController = Get.find<GlobalController>();
  FocusNode _focusNode = FocusNode();

  Province? currentProvince;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentProvince = widget.latlonModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SlidingBox(
          minHeight: 230,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          style: BoxStyle.shadow,
          collapsed: true,
          backdrop: Backdrop(
            overlay: true,
            color: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                Column(
                  children: [
                    Flexible(
                      child: FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            initialCenter:
                                LatLng(widget.latlonModel.latitude, widget.latlonModel.longitude),
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            TileLayer(
                              urlTemplate:
                                  "http://maps.openweathermap.org/maps/2.0/weather/TA2/{z}/{x}/{y}?appid=892d0acea2fe1c2327db103cbf7b5496",
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(widget.latlonModel.latitude, widget.latlonModel.longitude),
                                  width: 150,
                                  height: 150,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    size: 500 / zoomValue,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  right: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return ProvinceLatLon.provinces.map((e) => e.name).where((option) {
                          return option.contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (selection) {
                        var tempSelectResult = ProvinceLatLon.getLatLonModel(selection);
                        if(tempSelectResult.isNotEmpty){
                          currentProvince = tempSelectResult.first;
                          widget.latlonModel.latitude = tempSelectResult.first.latitude;
                          widget.latlonModel.longitude = tempSelectResult.first.longitude;
                          mapController.move(LatLng(widget.latlonModel.latitude,widget.latlonModel.longitude), zoomValue);
                          globalController.refreshWeatherData(currentProvince!);
                          _focusNode.unfocus();
                          setState(() {

                          });
                        }
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        _focusNode = focusNode;
                        return TextField(
                          controller: textEditingController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent, // Custom border colort
                              ),
                            ),filled: true,
                            fillColor: Colors.white.withOpacity(0.6),
                            hintText: 'Nhập địa điểm, tỉnh thành',
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              key: UniqueKey(),
              children: [
                HeaderCollapsedWidget(key: UniqueKey(),data: currentProvince),
                Obx(()=>Column(
                  children: [
                    CurrentWeatherWidget(
                      key: UniqueKey(),
                      weatherDataCurrent:
                      globalController.getData().getCurrentWeather(),
                      isShowWindyInfo: false,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly:
                        globalController.getData().getHourlyWeather()),
                    DailyDataForecast(
                      weatherDataDaily:
                      globalController.getData().getDailyWeather(),
                    ),
                  ],
                )),

              ],
            ),
          ),
          collapsedBody: Column(
            key: UniqueKey(),
            children: [
              HeaderCollapsedWidget(key: UniqueKey(),data: currentProvince),
              Obx(()=>CurrentWeatherWidget(
                key: UniqueKey(),
                weatherDataCurrent:
                globalController.getData().getCurrentWeather(),
                isShowWindyInfo: false,
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          },
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.home,
          ),
        ),
      ),
    );
  }
}
