import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';
class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final MapController mapController = MapController();

  double zoomValue = 15;

  @override
  Widget build(BuildContext context) {
    // mapController.zoom.listen((event) {
    //   zoomValue = event.zoom;
    // });
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      //drawer: buildDrawer(context, PluginZoomButtons.route),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: const LatLng(21.0283207,105.8540217),//10.805442570651401, 106.63445502981594
                        zoom: 15,
                      ),
                      nonRotatedChildren: const [
                        // FlutterMapZoomButtons(
                        //   minZoom: 4,
                        //   maxZoom: 19,
                        //   mini: true,
                        //   padding: 10,
                        //   alignment: Alignment.bottomRight,
                        // ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        TileLayer(
                          urlTemplate:
                          "http://maps.openweathermap.org/maps/2.0/weather/TA2/{z}/{x}/{y}?appid=892d0acea2fe1c2327db103cbf7b5496",
                          backgroundColor: Colors.transparent,
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: const LatLng(21.0283207,105.8540217),
                              width: 150,
                              height: 150,
                              /*builder: (BuildContext context) {
                                return Icon(Icons.location_on_rounded,size: 500/zoomValue,color: Colors.red,);
                              },*/ child: Icon(Icons.location_on_rounded,size: 500/zoomValue,color: Colors.red,),
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
          // jk
        ],
      ),
    );
    return const Placeholder();
  }
}
