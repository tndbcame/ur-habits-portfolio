import 'package:flutter/material.dart';

class CalenderDateButton extends StatefulWidget {
  const CalenderDateButton({
    super.key,
    required this.normalColor,
    required this.pressedColor,
    required this.onTap,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.alignment,
    this.hasLeftBorder = false,
    this.hasTopBorder = false,
    this.hasRightBorder = false,
    this.hasBottomBorder = false,
    this.border,
    this.borderRadius,
    this.borderColor,
  });

  final Color normalColor;
  final Color pressedColor;
  final VoidCallback onTap;
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final bool hasLeftBorder;
  final bool hasTopBorder;
  final bool hasRightBorder;
  final bool hasBottomBorder;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;

  @override
  State<CalenderDateButton> createState() => _CalenderDateButtonState();
}

class _CalenderDateButtonState extends State<CalenderDateButton> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.normalColor;
  }

  void _onTapDown(TapDownDetails details) {
    _changeColor(widget.pressedColor);
  }

  void _onTapUp(TapUpDetails details) {
    _changeColor(widget.normalColor);
  }

  void _onTapCancel() {
    _changeColor(widget.normalColor);
  }

  void _changeColor(Color newColor) {
    setState(() {
      currentColor = newColor;
    });
  }

  Widget _buildButtonContent() {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      alignment: widget.alignment,
      decoration: BoxDecoration(
        color: currentColor,
        border: widget.border,
        borderRadius: widget.borderRadius,
      ),
      child: widget.child,
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
