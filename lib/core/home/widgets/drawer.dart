import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce/core/constants/appColor.dart';
import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 165, 164, 162),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40, color: Colors.black),
                ),
                Text(
                  Cachehelper.getData(key: 'username'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Full name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            Cachehelper.getData(key: 'fullname'),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 59, 72, 79),
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Email address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            Cachehelper.getData(key: 'email'),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 59, 72, 79),
              fontSize: 15,
            ),
          ),
        ),
        Divider(
          color: AppColors.primaryColor,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          trailing: const Icon(Icons.logout, color: Colors.red, size: 30),
          onTap: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'Logout',
              desc: 'Are you sure you want to logout?',
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnOkOnPress: () {
                Cachehelper.removeData(key: 'username');
                Cachehelper.removeData(key: 'fullname');
                Cachehelper.removeData(key: 'email');
                Cachehelper.removeData(key: 'id');
                Cachehelper.removeData(key: 'cartId');
                Navigator.pushReplacementNamed(context, 'login');
              },
            ).show();
          },
        ),
      ],
    );
  }
}
