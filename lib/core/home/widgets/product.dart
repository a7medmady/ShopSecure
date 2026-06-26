import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/home/model/productModel.dart';
import 'package:e_commerce/core/home/screens/productCard.dart';
import 'package:e_commerce/core/home/widgets/love.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final List<ProductModel> listOfProducts;
  const Product({super.key, required this.listOfProducts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listOfProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductCard(product: listOfProducts[index]),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Positioned(top: 0, right: 0, 
                        child: Love(
                          product: listOfProducts[index],
                        )),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: listOfProducts[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      listOfProducts[index].title,
                      textAlign: TextAlign.center,
                    ),

                    Text('\$ ${listOfProducts[index].price.toString()}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
