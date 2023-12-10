import 'package:app_dubaothoitiet/components/compass.dart';
import 'package:app_dubaothoitiet/components/edit_profile.dart';
import 'package:app_dubaothoitiet/components/map_screen.dart';
import 'package:app_dubaothoitiet/pages/login_page.dart';
import 'package:app_dubaothoitiet/utils/province.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:app_dubaothoitiet/widgets/hourly_data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_dubaothoitiet/controller/global_controller.dart';
import 'package:app_dubaothoitiet/utils/custom_colors.dart';
import 'package:app_dubaothoitiet/widgets/comfort_level.dart';
import 'package:app_dubaothoitiet/widgets/current_weather_widget.dart';
import 'package:app_dubaothoitiet/widgets/daily_data_forecast.dart';

import '../widgets/hearder_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  Province? currentProvince;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                String email = await LocalStorage.read('email');
                if(context.mounted){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfilePage(email: email)),
                  );
                }
              },
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapScreen(
                        latlonModel: currentProvince??globalController.getCurrentProvince(),
                      )),
                );
              },
              child: const Icon(Icons.map_outlined),
            ),
            const SizedBox(width: 50),
            GestureDetector(
              onTap: () async {
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CompassScreen()));
                }
              },
              child: const Icon(Icons.compass_calibration_rounded),
            ),
            const SizedBox(width: 50),
            GestureDetector(
              onTap: () async {
                await LocalStorage.save('access_token', '');
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                }
              },
              child: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: NetworkImage("https://www.gizmochina.com/wp-content/uploads/2022/06/iOS-16-Weather-Wallpaper-1-GIZMOCHINA-Small.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/clouds.png",
                      height: 200,
                      width: 200,
                    ),
                    const CircularProgressIndicator()
                  ],
                ))
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0,right: 16.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF0D47A1)),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Province>(
                                  value: currentProvince??globalController.getCurrentProvince(),
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  iconEnabledColor: const Color(0xFF0D47A1),
                                  style: const TextStyle(
                                    color: Color(0xFF0D47A1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  onChanged: (value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      globalController.refreshWeatherData(value!);
                                      currentProvince = value!;
                                    });
                                  },
                                  items: ProvinceLatLon.provinces
                                      .map<DropdownMenuItem<Province>>((value) {
                                    return DropdownMenuItem<Province>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: HeaderWidget(
                                key: UniqueKey(),
                                city: globalController.getCityName().value),
                          ),

                        ],
                      ),
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                          weatherDataHourly:
                              globalController.getData().getHourlyWeather()),
                      DailyDataForecast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather()),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
