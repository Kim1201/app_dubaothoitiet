import 'dart:convert';

import 'package:app_dubaothoitiet/model/user_model.dart' as user;
import 'package:app_dubaothoitiet/pages/login_page.dart';
import 'package:app_dubaothoitiet/screens/home_screen.dart';
import 'package:app_dubaothoitiet/utils/api_url.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key,this.email = ''}) : super(key: key);
  final String email;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditing = false;
  user.User? userModel;

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _nickNameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    var response = await MongoDBAPI()
        .findOneCallMongo(context, collection: 'user', filters: {
      'email': widget.email,
    });
    var tempJsonToMap = json.decode(response);
    userModel = user.User.fromJson(tempJsonToMap['document']);

    if (userModel != null) {
      _nameTextEditingController.text = userModel!.name;
      _emailTextEditingController.text = userModel!.email;
      _nickNameTextEditingController.text = userModel!.nickname;
      setState(() {});
    }
  }

  _updateUserData() async {
    var response = await MongoDBAPI()
        .updateOneCallMongo(context, collection: 'user', dataUpdates: {
      if(_nameTextEditingController.text.isNotEmpty)
        "name": _nameTextEditingController.text,
      if(_nickNameTextEditingController.text.isNotEmpty)
        "nickname": _nickNameTextEditingController.text,
    },id: userModel!.id);
    var tempJsonToMap = json.decode(response);
    if(tempJsonToMap["matchedCount"]==1&&tempJsonToMap["modifiedCount"]==1){
      _getUserData();
    }

  }

  // Hàm này được gọi khi người dùng ấn nút "Lưu"
  _saveChanges() async {
    await _updateUserData();
    setState(() {
      // Kết thúc chế độ chỉnh sửa
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Trang Cá nhân'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  _saveChanges();
                } else {
                  isEditing = true;
                }
              });
            },
          ),
          if(isEditing)
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                isEditing = false;
                setState(() {
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const SizedBox(height:30),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                  const SizedBox(height: 50),
                  isEditing
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _emailTextEditingController,
                            enabled: false,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black26), //<-- SEE HERE
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black26), //<-- SEE HERE
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black26), //<-- SEE HERE
                              ),
                              hintText: userModel?.email ?? '',
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          userModel?.email ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  const SizedBox(height: 16),
                  const Text(
                    'Thông tin tài khoản',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  isEditing
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameTextEditingController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.black26), //<-- SEE HERE
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.black26), //<-- SEE HERE
                        ),
                        hintText: userModel?.name ?? '',
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Text(
                    userModel?.name ?? '',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  isEditing
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller:
                            _nickNameTextEditingController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black26), //<-- SEE HERE
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black26), //<-- SEE HERE
                              ),
                              hintText: userModel?.nickname ?? '',
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          userModel?.nickname ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  if(isEditing)
                    const SizedBox(height: 250,),
                  if(!isEditing)
                    const SizedBox(height: 150,)
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if(!isEditing)
              Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      await LocalStorage.save('access_token', '');
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                                (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black12,
                      minimumSize: const Size(88, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    child: const Text(
                      'Đăng Xuất',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
    );
  }
}
