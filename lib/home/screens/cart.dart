import 'package:e_commerce/constants/appColor.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/state.dart';
import 'package:e_commerce/home/widgets/productCart.dart';
import 'package:e_commerce/home/widgets/totalPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: cubit.listOfCart.isEmpty
                    ? const Center(child: Text('Your Cart is Empty'))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Cart',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.backgroundColor,
                              ),
                            ),

                            Text(
                              'Review your items before secure checkout.',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),

                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProductCart(
                                  product: cubit.listOfCart[index],
                                  onDelete: () {
                                    cubit.removeFromCart(index);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                  color: Colors.grey,
                                  indent: 20,
                                  endIndent: 20,
                                );
                              },
                              itemCount: cubit.listOfCart.length,
                            ),

                            const SizedBox(height: 200),
                          ],
                        ),
                      ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TotalPrice(
                    subTotal: cubit.calculateSubTotal(),
                    total: cubit.calculateTotal(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
