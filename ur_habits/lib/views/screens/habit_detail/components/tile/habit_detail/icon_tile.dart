import 'package:flutter/material.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.selectedIconIndex,
    required this.habitIcons,
    required this.onTapIcon,
  });

  final int selectedIconIndex;
  final Map<int, IconData> habitIcons;
  final VoidCallback onTapIcon;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.icon.text,
      itemHeight: 80,
      onTap: onTapIcon,
      mainItem: Expanded(
        child: Icon(
          habitIcons[selectedIconIndex],
          color: Theme.of(context).primaryColor,
        ),
      ),
      attachAllow: true,
    );
  }
}
