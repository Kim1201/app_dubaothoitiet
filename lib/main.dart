import 'package:app_dubaothoitiet/app_service.dart';
import 'package:app_dubaothoitiet/model/config.dart';
import 'package:flutter/material.dart';
import 'package:app_dubaothoitiet/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  // providers: [
  //   ChangeNotifierProvider<Config>(create: (_) => realmConfig),
  //   Provider<AppServices>(
  //       create: (_) => AppServices(realmConfig.appId, realmConfig.baseUrl)),
  // ],
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}