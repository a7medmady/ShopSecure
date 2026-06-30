import 'package:e_commerce/core/constants/appColor.dart';
import 'package:e_commerce/core/home/cubit/cubit.dart';
import 'package:e_commerce/core/home/cubit/state.dart';
import 'package:e_commerce/core/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String routename = 'display';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  void initState() {
    super.initState();
    var cubit = HomeCubit.get(context);
    cubit.products('All');
    cubit.categories();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 208, 206, 206),
              drawer: Drawer(
                child: MyDrawer(),
              ),
              appBar: AppBar(
                title: Text(
                  'ShopSecure',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ],
              ),

              body: cubit.screens[cubit.currentIndex],

              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 30),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart, size: 30),
                    label: 'Cart',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.person, size: 30),
                  //   label: 'Profile',
                  // ),
                ],

                backgroundColor: Colors.transparent,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changeScreen(index),
                selectedItemColor: AppColors.backgroundColor,
                unselectedItemColor: AppColors.primaryColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
