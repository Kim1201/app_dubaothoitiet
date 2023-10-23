// import 'package:app_dubaothoitiet/api/custom_color.dart';
import 'package:app_dubaothoitiet/pages/login_page.dart';
import 'package:app_dubaothoitiet/widgets/harder_widget.dart';
import 'package:app_dubaothoitiet/widgets/hourly_data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_dubaothoitiet/controller/global_controller.dart';
import 'package:app_dubaothoitiet/utils/custom_colors.dart';
import 'package:app_dubaothoitiet/widgets/comfort_level.dart';
import 'package:app_dubaothoitiet/widgets/current_weather_widget.dart';
import 'package:app_dubaothoitiet/widgets/daily_data_forecast.dart';
import 'package:app_dubaothoitiet/widgets/hourly_data_widget.dart';

import '../components/profile_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

       title: Row(
         children: [
           SizedBox(width:45),
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const ProfilePage()),
               );
             },
             child: Icon(
               Icons.person
                   

             ),
           ),
           SizedBox(width:50),
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const HomeScreen()),
               );
             },
             child: Icon(
                 Icons.ac_unit_rounded

             ),
           ),
           SizedBox(width:50),
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const Drawer()),
               );
             },
             child: Icon(
                 Icons.map_outlined


             ),
           ),
           SizedBox(width:50),

           GestureDetector(
             onTap: ()async{
               await FirebaseAuth.instance.signOut();
               Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>
                   LoginPage()), (route) => false);

             },
             child: Icon(
                 Icons.logout_outlined

             ),
           ),
         ],
       ),

        backgroundColor: Colors.black12,

      ),

      body: SafeArea(
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
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    // for our current temp ('current')
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
                    Container(
                        margin: EdgeInsets.all(10),
                        child:ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>
                                LoginPage()), (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black12,
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                          child: Text ('Đăng Xuất',style: TextStyle(fontSize: 20,color: Colors.red),),






                        )
                    )
                  ],
                ),
              )),
      ),
    );

  }


}
