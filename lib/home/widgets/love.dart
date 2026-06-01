import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/state.dart';
import 'package:e_commerce/home/model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Love extends StatelessWidget {
  final ProductModel product;
  const Love({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          child: Center(
            child: IconButton(
              onPressed: () {
                if (cubit.listOfLove.contains(product)) {
                  cubit.removeFromLove(product);
                } else {
                  cubit.insertToLove(product);
                }
              },
              icon: !cubit.listOfLove.contains(product)
                  ? Icon(Icons.favorite_border)
                  : Icon(Icons.favorite),
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
