import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const OnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.fill,
          ),
        ),

        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 226, 226).withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 37, 35, 35),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
