import 'package:e_commerce/core/constants/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const Button({
    super.key, 
    required this.title, 
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 325.w,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(title,
          style: TextStyle(
            fontSize: AppFonts.medium,
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
          )
          ),
      ),
    );
  }
}