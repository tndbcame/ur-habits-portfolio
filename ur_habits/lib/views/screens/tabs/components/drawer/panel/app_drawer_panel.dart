import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';

class AppDrawerPanel extends StatelessWidget {
  const AppDrawerPanel({
    super.key,
    required this.width,
    required this.title,
    this.titleColor,
    required this.widgetList,
    this.partnerCount,
  });

  final double width;
  final String title;
  final Color? titleColor;
  final List<Widget> widgetList;
  final int? partnerCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: kLightGray5,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, color: titleColor),
                    ),
                    if (partnerCount != null)
                      Text(
                        '$partnerCount/$limitPartner',
                        style: TextStyle(fontSize: 14, color: titleColor),
                      ),
                  ],
                ),
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
              SizedBox(
                height: 90,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...widgetList,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
