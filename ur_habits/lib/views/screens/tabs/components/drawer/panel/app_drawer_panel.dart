import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class AppDrawerPanel extends StatelessWidget {
  const AppDrawerPanel({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    this.titleColor,
    required this.widgetList,
  });

  final double width;
  final double height;
  final String title;
  final Color? titleColor;
  final List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kLightGray5,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: titleColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: kLightGray3,
              ),
              ...widgetList,
            ],
          ),
        ),
      ),
    );
  }
}
