import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class OverlayDialog extends StatelessWidget {
  const OverlayDialog({
    super.key,
    required this.message,
    required this.animatoin,
    this.messageFontSize,
    this.confirmButtonColor,
  });

  final String message;
  final Animation<double> animatoin;
  final double? messageFontSize;
  final Color? confirmButtonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animatoin,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: kTextBaseColor,
              border: Border.all(
                color: kTextBaseColorBlack,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: messageFontSize ?? 16,
                    color: kTextBaseColorBlack,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
