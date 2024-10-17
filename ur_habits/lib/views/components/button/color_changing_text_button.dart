import 'package:flutter/material.dart';

class ColorChangingTextButton extends StatefulWidget {
  const ColorChangingTextButton({
    super.key,
    required this.normalColor,
    required this.pressedColor,
    required this.onTap,
    this.isBoldText = false,
    this.leftIcon,
    this.labelText,
    this.textSize,
    this.rightIcon,
    this.mainAxisAlignment,
  });

  final Color normalColor;
  final Color pressedColor;
  final VoidCallback onTap;
  final bool isBoldText;
  final IconData? leftIcon;
  final String? labelText;
  final double? textSize;
  final IconData? rightIcon;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<ColorChangingTextButton> createState() =>
      _ColorChangingTextButtonState();
}

class _ColorChangingTextButtonState extends State<ColorChangingTextButton> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          if (widget.leftIcon != null)
            Icon(
              widget.leftIcon,
              color: currentColor,
            ),
          if (widget.labelText != null)
            Text(
              widget.labelText!,
              style: TextStyle(
                color: currentColor,
                fontWeight:
                    widget.isBoldText ? FontWeight.bold : FontWeight.normal,
                fontSize: widget.textSize ?? 16.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          if (widget.rightIcon != null)
            Icon(
              widget.rightIcon,
              color: currentColor,
            ),
        ],
      ),
    );
  }
}
