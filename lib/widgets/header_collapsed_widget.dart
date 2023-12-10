import 'package:app_dubaothoitiet/controller/global_controller.dart';
import 'package:app_dubaothoitiet/utils/province.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderCollapsedWidget extends StatefulWidget {
  const HeaderCollapsedWidget({Key? key, this.data}) : super(key: key);

  final Province? data;

  @override
  State<HeaderCollapsedWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderCollapsedWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    if(widget.data!=null){
      getAddress(widget.data!.latitude, widget.data!.longitude);
      city = widget.data!.name;
    }else{
      getAddress(globalController.getLattitude().value,
          globalController.getLongitude().value);
    }
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      if(city.isEmpty){
        city = place.locality!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(fontSize: 25, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.5),
          ),
        ),
      ],
    );
  }
}
