import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/state.dart';
import 'package:e_commerce/home/model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Quantity extends StatefulWidget {
  final ProductModel product;
  const Quantity({super.key, required this.product});

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.increaseQuantity(widget.product, context);
                  },
                  icon: Icon(Icons.add),
                ),
                Text(widget.product.quantity.toString()),
                IconButton(
                  onPressed: () {
                    cubit.decreaseQuantity(widget.product, context);
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
