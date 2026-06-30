import 'package:e_commerce/core/Splash/widgets/onboard.dart';
import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

String routename = 'page';

class Boarding extends StatefulWidget {
  const Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              // 1st page
              OnBoarding(
                title: 'Welcome to ShopScure',
                description:
                    'Discover thousands of products from top brands all in one place. Shop easily and enjoy a seamless online shopping experience.',
                image:
                    'https://wallpapers.com/images/hd/e-commerce-1920-x-1080-wallpaper-tb4uqckgoo0883zw.jpg',
              ),

              // 2nd page
              OnBoarding(
                title: 'Best Deals',
                description:
                    'Find exclusive discounts and special offers on your favorite products every day',
                image:
                    'https://5.imimg.com/data5/SELLER/Default/2023/10/350122007/ED/JG/WV/77425379/ecommerce-solutions-500x500.png',
              ),

              // 3rd page
              OnBoarding(
                title: 'Secure Payments',
                description:
                    'Shop with confidence using safe and trusted payment methods designed to protect your information',
                image:
                    'https://www.cloudways.com/blog/wp-content/uploads/Ecommerce-Shopping-Infographics.png',
              ),
            ],
          ),

          // indicator
          Positioned(
            bottom: 90,
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: .3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.thinUnderground,
                  ),
                ),
              ),
            ),
          ),

          // skip button
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                if (currentIndex == 2) {
                  Cachehelper.saveData(key: 'isNotFirstUsingApp', value: true);
                  Navigator.pushNamed(context, 'login');
                } else {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                  );
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: .3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        currentIndex == 2 ? 'Get Started' : 'Skip',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
