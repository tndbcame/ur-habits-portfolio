import 'package:flutter/material.dart';

class ColorChangingBoxButton extends StatefulWidget {
  const ColorChangingBoxButton({
    super.key,
    required this.normalColor,
    required this.normalTextColor,
    required this.pressedColor,
    required this.pressedTextColor,
    required this.onTap,
    this.isBoldText = false,
    this.leftIcon,
    this.leftIconSize,
    this.labelText,
    this.textSize,
    this.textPadding = 0,
    this.height,
    this.width,
    this.hasLeftBorder = false,
    this.hasTopBorder = false,
    this.hasRightBorder = false,
    this.hasBottomBorder = false,
    this.borderRadius,
    this.borderColor,
    this.rightIcon,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final Color normalColor;
  final Color normalTextColor;
  final Color pressedColor;
  final Color pressedTextColor;
  final VoidCallback onTap;
  final bool isBoldText;
  final IconData? leftIcon;
  final double? leftIconSize;
  final String? labelText;
  final double? textSize;
  final double textPadding;
  final double? height;
  final double? width;
  final bool hasLeftBorder;
  final bool hasTopBorder;
  final bool hasRightBorder;
  final bool hasBottomBorder;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final IconData? rightIcon;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<ColorChangingBoxButton> createState() => _ColorChangingBoxButtonState();
}

class _ColorChangingBoxButtonState extends State<ColorChangingBoxButton> {
  late Color currentColor;
  late Color currentTextColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.normalColor;
    currentTextColor = widget.normalTextColor;
  }

  void _onTapDown(TapDownDetails details) {
    _changeColor(widget.pressedColor, widget.pressedTextColor);
  }

  void _onTapUp(TapUpDetails details) {
    _changeColor(widget.normalColor, widget.normalTextColor);
  }

  void _onTapCancel() {
    _changeColor(widget.normalColor, widget.normalTextColor);
  }

  void _changeColor(Color newColor, Color newTextColor) {
    setState(() {
      currentColor = newColor;
      currentTextColor = newTextColor;
    });
  }

  Widget _buildButtonContent() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: currentColor,
        border: _buildBorder(),
        borderRadius: widget.borderRadius,
      ),
      child: _buildButtonRow(),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        if (widget.leftIcon != null)
          Icon(
            widget.leftIcon,
            color: currentTextColor,
            size: widget.leftIconSize,
          ),
        if (widget.labelText != null)
          Padding(
            padding: EdgeInsets.all(widget.textPadding),
            child: Text(
              widget.labelText!,
              style: TextStyle(
                color: currentTextColor,
                fontWeight:
                    widget.isBoldText ? FontWeight.bold : FontWeight.normal,
                fontSize: widget.textSize ?? 16.0,
              ),
            ),
          ),
        if (widget.rightIcon != null)
          Icon(
            widget.rightIcon,
            color: currentTextColor,
          ),
      ],
    );
  }

  Border _buildBorder() {
    return Border(
      left: widget.hasLeftBorder
          ? BorderSide(color: widget.borderColor ?? const Color(0xFF000000))
          : BorderSide.none,
      top: widget.hasTopBorder
          ? BorderSide(color: widget.borderColor ?? const Color(0xFF000000))
          : BorderSide.none,
      right: widget.hasRightBorder
          ? BorderSide(color: widget.borderColor ?? const Color(0xFF000000))
          : BorderSide.none,
      bottom: widget.hasBottomBorder
          ? BorderSide(color: widget.borderColor ?? const Color(0xFF000000))
          : BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: _buildButtonContent(),
    );
  }
}
