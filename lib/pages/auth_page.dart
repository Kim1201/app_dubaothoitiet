import 'package:app_dubaothoitiet/screens/home_screen.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_dubaothoitiet/pages/login_page.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<String> _checkAccessToken() async {
    return await LocalStorage.read('access_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        initialData: '',
        future: _checkAccessToken(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!=''){
              return const HomeScreen();
            }
            return LoginPage();
          }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}