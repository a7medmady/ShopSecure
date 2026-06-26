import 'package:e_commerce/core/constants/appColor.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScrollHorizontal extends StatefulWidget {
  final List listOfCategories;
  final Function (String) changeItem;
  String item;
  ScrollHorizontal({
    super.key,
    required this.listOfCategories,
    required this.item,
    required this.changeItem,
  });

  @override
  State<ScrollHorizontal> createState() => _ScrollHorizontalState();
}

class _ScrollHorizontalState extends State<ScrollHorizontal> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listOfCategories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              widget.changeItem(widget.listOfCategories[index].name);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: widget.item == widget.listOfCategories[index].name
                    ? AppColors.backgroundColor
                    : const Color.fromARGB(255, 236, 224, 224),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    widget.listOfCategories[index].name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: widget.item == widget.listOfCategories[index].name
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
