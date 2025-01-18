import 'package:flutter/material.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_bar.dart';

class UrHabitsScrollView extends StatelessWidget {
  const UrHabitsScrollView({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return UrHabitsScrollBar(
        child: SingleChildScrollView(
      child: child,
    ));
  }
}
