import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/ui_helper.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/view_models/providers/firebase_habits_provider.dart';
import 'package:ur_habits/view_models/providers/isar_habits_provider.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/views/screens/habit_detail/habit_details.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/screens/tabs/home_tab/components/habit_reorderable_list_panel.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({
    super.key,
    this.usePublicHabits,
    required this.routeManager,
  });

  final RouteManager routeManager;
  final bool? usePublicHabits;

  @override
  ConsumerState<HomeTab> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends ConsumerState<HomeTab> {
  bool _isLoading = false;

  void setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  /// 習慣の更新
  Future<void> _updateHabit(
    BuildContext context,
    HabitView habitItem,
    bool isPublic,
  ) async {
    int preHabitType = habitItem.habitType;
    var publicHabitsSize =
        ref.read(firebaseHabitsProvider.notifier).countHabits();
    if (isPublic) {
      publicHabitsSize -= 1;
    }
    final habit = await widget.routeManager.push<HabitView>(
        context,
        HabitDetailsScreen(
          habit: habitItem,
          isUpdate: true,
          publicHabitsSize: publicHabitsSize,
        ));

    if (habit == null) return;

    if (habit.isDeleted == 1) {
      //論理削除されている場合はリストから削除
      if (habit.habitType == 1) {
        ref.read(isarHabitsProvider.notifier).deleteHabit(habit);
      } else {
        setIsLoading(true);
        try {
          await ref.read(firebaseHabitsProvider.notifier).deleteHabit(habit.id);
          await ref.read(firebaseHabitsProvider.notifier).fetchHabits();
        } finally {
          setIsLoading(false);
        }
      }

      return;
    }

    if (preHabitType != habit.habitType) {
      setIsLoading(true);
      try {
        if (habit.habitType == 1) {
          await ref.read(isarHabitsProvider.notifier).addHabitAsync(habit);
          await ref.read(firebaseHabitsProvider.notifier).deleteHabit(habit.id);
        } else {
          await ref.read(firebaseHabitsProvider.notifier).addHabit(habit, true);
          await ref.read(isarHabitsProvider.notifier).deleteHabitAsync(habit);
        }
        await ref.read(firebaseHabitsProvider.notifier).fetchHabits();
      } finally {
        setIsLoading(false);
      }
      return;
    }

    if (habit.habitType == 1) {
      setState(() {
        ref.read(isarHabitsProvider.notifier).updateHabit(habit);
      });
    } else {
      setIsLoading(true);
      try {
        await ref.read(firebaseHabitsProvider.notifier).updateHabit(habit);
      } finally {
        setIsLoading(false);
      }
    }
  }

  /// リオーダー処理
  void _reorderHabits(
      List<HabitView> habits, int oldIndex, int newIndex, bool isPublic) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final HabitView item = habits.removeAt(oldIndex);
      habits.insert(newIndex, item);
    });

    if (isPublic) {
      ref.read(firebaseHabitsProvider.notifier).sortHabits(habits);
    } else {
      ref.read(isarHabitsProvider.notifier).sortHabits(habits);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight =
        UIHelper.calcScreenSize(screenHeight, statusBarHeight);
    final privateHabits = ref.watch(isarHabitsProvider);
    List<HabitView>? publicHabits;
    if (widget.usePublicHabits != null) {
      publicHabits = ref.watch(firebaseHabitsProvider);
    }
    if (_isLoading) {
      return SizedBox(
        height: availableHeight * 0.85,
        child: const Center(
          child: CustomIndicator(
            color: kTextBaseColor,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all((screenWidth * 0.03)),
            child: HabitReorderableListPanel(
              title: Text(
                TextContents.habitPrivate.text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
              habits: privateHabits,
              screenWidth: screenWidth,
              screenHeight: publicHabits != null
                  ? screenHeight * 0.375
                  : screenHeight * 0.75 + screenWidth * 0.03,
              isPublic: false,
              reorderHabits: _reorderHabits,
              updateHabit: _updateHabit,
              noHabitsMessage: TextContents.noHabit.text,
            ),
          ),
          if (publicHabits != null)
            Padding(
              padding: EdgeInsets.only(
                  left: (screenWidth * 0.03),
                  right: (screenWidth * 0.03),
                  bottom: (screenWidth * 0.03)),
              child: HabitReorderableListPanel(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TextContents.habitPublic.text,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${publicHabits.length}/3',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                habits: publicHabits,
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.375,
                isPublic: true,
                reorderHabits: _reorderHabits,
                updateHabit: _updateHabit,
                noHabitsMessage: TextContents.noHabit.text,
              ),
            ),
        ],
      ),
    );
  }
}
