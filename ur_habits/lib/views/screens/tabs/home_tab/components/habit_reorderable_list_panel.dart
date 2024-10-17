import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';
import 'package:ur_habits/views/screens/habit_record/habit_records.dart';
import 'package:ur_habits/views/screens/tabs/components/tile/habit_list_tile.dart';

class HabitReorderableListPanel extends StatelessWidget {
  const HabitReorderableListPanel({
    super.key,
    required this.title,
    required this.habits,
    required this.screenWidth,
    required this.screenHeight,
    required this.isPublic,
    required this.updateHabit,
    required this.reorderHabits,
    this.noHabitsMessage,
  });

  final Widget title;
  final List<HabitView> habits;
  final double screenWidth;
  final double screenHeight;
  final bool isPublic;
  final Future<void> Function(
    BuildContext context,
    HabitView habitItem,
    bool isPublic,
  ) updateHabit;
  final void Function(
    List<HabitView> habits,
    int oldIndex,
    int newIndex,
    bool isPublic,
  ) reorderHabits;
  final String? noHabitsMessage;

  /// タイトルコンテナをビルド
  Widget _buildTitleContainer(Widget title, double screenWidth) {
    return Container(
      height: screenWidth * 0.1,
      width: screenWidth,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: kLightGray,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.015),
        child: title,
      ),
    );
  }

  /// リストビューをビルド
  Widget _buildHabitListView(
      List<HabitView> habits, double screenWidth, bool isPublic) {
    return ReorderableListView.builder(
      itemBuilder: (ctx, i) => HabitListTile(
        key: Key('list_tile_key$i'),
        leading: Icon(
          habitIcons[habits[i].iconId],
          color: kTextBaseColorBlack,
        ),
        title: Text(
          habits[i].title,
          style: const TextStyle(color: kTextBaseColorBlack),
        ),
        subtitle: Text(
          habits[i].goal != null && habits[i].isGoal
              ? habits[i].goal!.title
              : '',
          style: const TextStyle(color: kTextBaseColorBlack),
        ),
        trailing: _buildEditButton(ctx, habits[i], isPublic),
        backgroundColor: kTextBaseColor,
        downColor: kLightGray8,
        height: 75,
        onTap: () async {
          await Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (ctx) => HabitRecordScreen(
                habit: habits[i],
                popLabel: HugeIcons.strokeRoundedHome03,
              ),
            ),
          );
        },
      ),
      itemCount: habits.length,
      onReorder: (int oldIndex, int newIndex) {
        reorderHabits(habits, oldIndex, newIndex, isPublic);
      },
    );
  }

  /// 編集ボタンをビルド
  Widget _buildEditButton(
      BuildContext context, HabitView habit, bool isPublic) {
    return Stack(
      children: [
        SpringButton(
          child: const Icon(
            HugeIcons.strokeRoundedPencilEdit02,
            color: kSecondBaseColor,
          ),
          onTap: () async {
            updateHabit(context, habit, isPublic);
          },
        ),
      ],
    );
  }

  /// 習慣がない場合のメッセージ
  Widget _buildNoHabitsMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            noHabitsMessage ?? '',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        color: kTextBaseColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildTitleContainer(title, screenWidth),
            habits.isNotEmpty
                ? Expanded(
                    child: _buildHabitListView(habits, screenWidth, isPublic),
                  )
                : _buildNoHabitsMessage(context),
          ],
        ),
      ),
    );
  }
}
