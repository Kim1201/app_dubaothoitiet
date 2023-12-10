import 'dart:convert';

import 'package:app_dubaothoitiet/app_service.dart';
import 'package:app_dubaothoitiet/pages/signup_page.dart';
import 'package:app_dubaothoitiet/screens/home_screen.dart';
import 'package:app_dubaothoitiet/utils/api_url.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:flutter/material.dart';
import 'package:app_dubaothoitiet/components/my_button.dart';
import 'package:app_dubaothoitiet/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool isHidePassword = true;

  // sign user in method
  void signUserIn() async {
    var response = await MongoDBAPI().loginUser(
        emailController.text, passwordController.text);
    try{
      var tempResponseMap = json.decode(response);
      if(tempResponseMap['access_token']!=null){
        LocalStorage.save('access_token', tempResponseMap['access_token']);
        LocalStorage.save('email', emailController.text);
        if(context.mounted){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
        }
      }else{
        throw Exception("Login thất bại!");
      }
    }catch(e){
      if(context.mounted){
        showDialog(context: context, builder: (context){
              return AlertDialog(
                  content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text("Đăng nhập thất bại",style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                                textAlign: TextAlign.center,),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
                              backgroundColor:  MaterialStatePropertyAll<Color>(Colors.black),
                            ),
                            child: const Text(
                              "Đóng",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )));
            });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Icon(
                  Icons.umbrella_rounded,
                  size: 80,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Chào mừng bạn đến với ứng dụng dự báo thời tiết',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Mật Khẩu',
                  suffixIcon:const Icon(Icons.remove_red_eye),
                  obscureText: isHidePassword,
                  callBackSuffix: (){
                    isHidePassword = !isHidePassword;
                    setState((){});
                  },
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 25),
                MyButton(
                  onTap: signUserIn,
                  title: 'Đăng nhập',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Chưa có tài khoản?',
                      style: TextStyle(color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signupage()),
                        );
                      },
                      child: const Text(
                        'Đăng Ký tài khoản ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}