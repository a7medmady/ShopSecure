import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/appColor.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/state.dart';
import 'package:e_commerce/home/model/productModel.dart';
import 'package:e_commerce/home/widgets/addCart.dart';
import 'package:e_commerce/home/widgets/love.dart';
import 'package:e_commerce/home/widgets/userReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 231, 231),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            color: AppColors.primaryColor,
          ),
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

        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Love(product: widget.product),
                          ),
                          CachedNetworkImage(
                            imageUrl: widget.product.image,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            widget.product.title,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '\$ ${widget.product.price.toString()}',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.backgroundColor,
                              ),
                            ),
                            Text(
                              widget.product.availability ?? 'Not Available',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 241, 157, 31),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product.rating.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),

                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 15),

                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "User Reviews",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    UserReview(review: widget.product.reviews),

                    SizedBox(height: 20),

                    AddCartButton(
                      onTap: () {
                        if (!cubit.listOfCart.contains(widget.product)) {
                          cubit.customSnackBar(
                            context,
                            '${widget.product.title} added to Cart Successfully',
                            Colors.green,
                          );
                        } else {
                          cubit.customSnackBar(
                            context,
                            '${widget.product.title} already added to Cart',
                            Colors.red,
                          );
                        }
                        cubit.addCart(widget.product);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
