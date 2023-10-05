import 'package:flutter/material.dart';
import 'package:app_dubaothoitiet/components/my_button.dart';
import 'package:app_dubaothoitiet/components/my_textfield.dart';
import 'package:app_dubaothoitiet/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class Signupage extends StatefulWidget {
  Signupage({super.key});

  @override
  State<Signupage> createState() => _SignupageState();
}

class _SignupageState extends State<Signupage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool isHidePassword = true;








  void signUserUp() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("ERROR: $e");
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
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 80,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
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

                // password textfield
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


                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: signUserUp,
                  title: 'Đăng ký',
                ),


                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Đăng Nhập Bằng ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // apple button

                  ],
                ),

                const SizedBox(height: 20),

                // not a member? register now

              ],
            ),
          ),
        ),
      ),
    );
  }


}