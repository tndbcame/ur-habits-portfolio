import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({
    super.key,
    required this.titles,
    required this.onToggle,
  });

  final List<String> titles;
  final void Function(int) onToggle;

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  /// トグルの状態を切り替える
  void _toggleSwitch() {
    setState(() {
      initialPosition = !initialPosition;
      widget.onToggle(initialPosition ? 0 : 1);
    });
  }

  /// アニメーションで動作するトグルボタンを作成する
  Widget _buildAnimatedToggle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedAlign(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
      alignment: initialPosition ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: screenWidth * 0.42,
          height: 25,
          decoration: ShapeDecoration(
            color: kTextBaseColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: Container(
        width: double.infinity,
        height: 30,
        decoration: ShapeDecoration(
          color: kLightGray2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Stack(
          children: <Widget>[
            _buildAnimatedToggle(context),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.titles[0],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.titles[1],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
