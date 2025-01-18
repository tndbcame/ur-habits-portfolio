import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';

class ColorChangingButton extends StatefulWidget {
  const ColorChangingButton({
    super.key,
    required this.isSelected,
    required this.normalColor,
    required this.pressedColor,
    required this.onTap,
    this.mainAxisAlignment,
  });

  final bool isSelected;
  final Color normalColor;
  final Color pressedColor;
  final VoidCallback onTap;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<ColorChangingButton> createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.normalColor;
  }

  void _onTapDown(TapDownDetails details) {
    _updateColor(widget.pressedColor);
  }

  void _onTapUp(TapUpDetails details) {
    _updateColor(widget.normalColor);
  }

  void _onTapCancel() {
    _updateColor(widget.normalColor);
  }

  void _updateColor(Color newColor) {
    setState(() {
      currentColor = newColor;
    });
  }

  Widget _buildSelectedIndicator() {
    return widget.isSelected
        ? Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: kTextBaseColor.applyOpacity(0),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: kTextBaseColor, width: 2),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: _buildSelectedIndicator()),
      ),
    );
  }
}
