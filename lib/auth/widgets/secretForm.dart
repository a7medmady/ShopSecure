import 'package:e_commerce/constants/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecretForm extends StatefulWidget {
  final String title;
  final String subtitle;
  final TextEditingController controller;
  final TextEditingController? parentController;
  final TextInputAction textInputAction;
  const SecretForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
    required this.parentController, 
    required this.textInputAction,
  });

  @override
  State<SecretForm> createState() => _SecretFormState();
}

class _SecretFormState extends State<SecretForm> {
  bool obscureText = false;
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
            textInputAction: widget.textInputAction,
            obscureText: !obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
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

              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? Icon(Icons.visibility, color: AppColors.secondaryColor)
                    : Icon(
                        Icons.visibility_off,
                        color: AppColors.secondaryColor,
                      ),
              ),
              labelText: widget.subtitle,
              labelStyle: TextStyle(
                fontSize: AppFonts.small,
                fontWeight: FontWeight.normal,
                color: AppColors.secondaryColor,
              ),
            ),
            validator: (value) {
              if (widget.parentController != null) {
                if (value != widget.parentController!.text) {
                  return 'Passwords do not match';
                }
              }
              if (value == null || value.isEmpty) {
                return 'Please enter your ${widget.title.toLowerCase()}';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
