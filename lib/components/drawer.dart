import 'package:flutter/material.dart';
import 'my_list_tile.dart';
class MyDrawer extends StatelessWidget{
  final void Function()? onProfileTap;
  final void Function()? onSinOutTap;
  MyDrawer(Key? key, this.onProfileTap, this.onSinOutTap);
 @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                )


            ),


            MyListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () => Navigator.pop(context),
            ),
            MyListTile(
              icon: Icons.person,
              text: 'P R O F I L E',
              onTap: onProfileTap,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: MyListTile(
                icon: Icons.person,
                text: 'L O G O U T',
                onTap: onSinOutTap,
              ),
            ),


          ],


        ),



      ),
    );
  }
  }

