import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}
class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    );
  }
}

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});
  bool isEditing = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Cá nhân'),
    actions: [
    IconButton(
    icon: Icon(Icons.edit),
    onPressed: () {
    // Cập nhật trạng thái chỉnh sửa khi nút được nhấn
    isEditing = !isEditing;

    },
    ),
    ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: 100),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nghề Nghiệp',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Giới thiệu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'I am a passionate software developer with experience in Dart and Flutter.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}