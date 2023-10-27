import 'package:flutter/material.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditing = false;
  String name = 'John Doe';
  String profession = 'Software Developer';
  String description = 'hahhah';

  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _jobTextEditingController = TextEditingController();
  final TextEditingController _personalDescriptionTextEditingController = TextEditingController();

  // Hàm này được gọi khi người dùng ấn nút "Lưu"
  void saveChanges() {



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
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  saveChanges();
                } else {
                  // Bắt đầu chế độ chỉnh sửa
                  isEditing = true;
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              const SizedBox(height: 80),
              //để vào chế độ chỉnh sửa thì có biến isEditing (Biến này có hai giá trị true hoặc false)
              // có hai widget là TextField (để chỉnh sửa text) và Text để view chữ.
              // isEditing? :  -- đoạn này tương đương đoạn code if(isEditing) else
              isEditing
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: TextField(
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
                          hintText: name,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                  )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 20),
              isEditing
              ?Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
                    hintText: profession,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              )
                  : Text(
                profession,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Giới thiệu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              isEditing
                  ?Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
                    hintText: description,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              )
                  : Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}
