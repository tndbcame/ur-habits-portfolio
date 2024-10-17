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

  /// 背景コンテナを作成する
  Widget _buildBackgroundContainer() {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: ShapeDecoration(
        color: kLightGray2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.titles.length,
          (index) => Text(
            widget.titles[index],
            style: const TextStyle(color: kTextBaseColorBlack),
          ),
        ),
      ),
    );
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
          child: Text(
            initialPosition ? widget.titles[0] : widget.titles[1],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: _toggleSwitch,
            child: _buildBackgroundContainer(),
          ),
          _buildAnimatedToggle(context),
        ],
      ),
    );
  }
}
