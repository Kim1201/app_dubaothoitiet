import 'dart:convert';

import 'package:app_dubaothoitiet/app_service.dart';
import 'package:app_dubaothoitiet/model/config.dart';
import 'package:app_dubaothoitiet/screens/home_screen.dart';
import 'package:app_dubaothoitiet/utils/api_url.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:flutter/material.dart';
import 'package:app_dubaothoitiet/components/my_button.dart';
import 'package:app_dubaothoitiet/components/my_textfield.dart';

class Signupage extends StatefulWidget {
  Signupage({super.key});

  @override
  State<Signupage> createState() => _SignupageState();
}

class _SignupageState extends State<Signupage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isHidePassword = true;

  late final AppServices appServiceRegisterUser;
  late final Config realmConfig;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initConfig();
  }

  _initConfig() async {
    realmConfig = await Config.getConfig('assets/config/atlasConfig.json');
    appServiceRegisterUser = AppServices(realmConfig.appId, realmConfig.baseUrl);
  }


  void signUserUp() async {
    await appServiceRegisterUser.registerUserEmailPassword(
        emailController.text, passwordController.text);
    var response = await MongoDBAPI()
        .loginUser(emailController.text, passwordController.text);
    try {
      var tempResponseMap = json.decode(response);
      if (tempResponseMap['access_token'] != null) {
        LocalStorage.save('access_token', tempResponseMap['access_token']);
        LocalStorage.save('email', emailController.text);
        if (context.mounted) {
          await MongoDBAPI()
              .insertOneCallMongo(context, collection: 'user', document: {
            'user_id': '',
            'email': emailController.text,
            'name': nameController.text,
            'nickname': nickNameController.text,
            'given_name': nickNameController.text,
            'family_name': nickNameController.text,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          }).then((value) {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            }
          });
        }
      } else {
        throw Exception("Đăng ký thất bại!");
      }
    } catch (e) {
      if (context.mounted) {
        _showDialogRegister("Đăng ký thất bại");
      }
    }
  }

  void _showDialogRegister(String value) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
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
                const SizedBox(height: 20),
                const Icon(
                  Icons.umbrella_rounded,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Chào mừng tới ứng dụng xem dự báo thời tiết \n Bạn điền thông tin phía dưới để tạo tài khoản!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),
                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'Họ tên',
                  callBackSuffix: () {
                    setState(() {});
                  },
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nickNameController,
                  hintText: 'Nick name',
                  obscureText: false,
                  callBackSuffix: () {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Mật Khẩu',
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  obscureText: isHidePassword,
                  callBackSuffix: () {
                    isHidePassword = !isHidePassword;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Xác nhận lại Mật Khẩu',
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  obscureText: isHidePassword,
                  callBackSuffix: () {
                    isHidePassword = !isHidePassword;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  onTap: signUserUp,
                  title: 'Đăng ký',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
