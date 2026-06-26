import 'package:e_commerce/core/constants/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String subtitle;
  final TextEditingController controller;
  const CustomForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: AppFonts.medium,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              labelText: widget.subtitle,
              labelStyle: TextStyle(
                fontSize: AppFonts.small,
                fontWeight: FontWeight.normal,
                color: AppColors.secondaryColor,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ${widget.title}';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
