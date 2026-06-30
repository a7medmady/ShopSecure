import 'package:e_commerce/core/constants/appColor.dart';
import 'package:e_commerce/core/home/cubit/cubit.dart';
import 'package:e_commerce/core/home/cubit/state.dart';
import 'package:e_commerce/core/home/widgets/productCart.dart';
import 'package:e_commerce/core/home/widgets/totalPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: state is CartLoading
                    ? const Center(child: CircularProgressIndicator())
                    : cubit.listOfCartForUser.isEmpty
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
                                  product: cubit.listOfCartForUser[index],
                                  onDelete: () {
                                    if (cubit.listOfCartForUser.isNotEmpty) {
                                      cubit.customSnackBar(
                                        context,
                                        '${cubit.listOfCartForUser[index].title} removed from cart',
                                        Colors.red,
                                      );
                                      // دا الصح
                                      // cubit.removeFromCart(
                                      //   index,
                                      //   Cachehelper.getData(key: 'cartId'),
                                      //   );

                                      cubit.removeFromCart(
                                        cubit.listOfCartForUser[index],
                                      );
                                    }
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
                              itemCount: cubit.listOfCartForUser.length,
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
