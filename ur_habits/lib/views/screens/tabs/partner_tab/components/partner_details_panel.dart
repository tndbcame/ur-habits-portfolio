import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/screens/habit_record/habit_records.dart';
import 'package:ur_habits/views/screens/tabs/components/tile/habit_list_tile.dart';

class PartnerDetailsPanel extends StatelessWidget {
  const PartnerDetailsPanel({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.partnerSnapshot,
    required this.firebaseViewModel,
    required this.routeManager,
  });

  final double screenWidth;
  final double screenHeight;
  final AsyncSnapshot partnerSnapshot;
  final FirebaseViewModel firebaseViewModel;
  final RouteManager routeManager;

  /// パネルを構築する
  Widget _buildPanel(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    String title,
    Color? titleColor,
    List<Widget> widgetList,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: kTextBaseColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildPanelHeader(context, screenWidth, title),
              ...widgetList,
            ],
          ),
        ),
      ),
    );
  }

  /// パートナーの習慣セクションを構築
  Widget _buildHabitsSection(
    BuildContext context,
    String partnerId,
  ) {
    return StreamBuilder(
      stream: firebaseViewModel.getHabitsSnapshot(partnerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildNoDataMessage();
        }
        var partnerHabits =
            firebaseViewModel.getPartnerHabits(snapshot.data!.docs);
        return FutureBuilder(
          future: partnerHabits,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildHabitListView(context, snapshot.data!);
            }
            return const Center(
              child: CustomIndicator(),
            );
          },
        );
      },
    );
  }

  /// データがない場合のメッセージを表示
  Widget _buildNoDataMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
      child: Row(
        children: [
          Text(
            TextContents.noDataFound.text,
            style: const TextStyle(color: kDarkGray),
          ),
        ],
      ),
    );
  }

  /// パネルヘッダーを構築
  Widget _buildPanelHeader(
      BuildContext context, double screenWidth, String title) {
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
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// 習慣のリストビューを構築
  Widget _buildHabitListView(BuildContext context, List<HabitView> habits) {
    return Column(
      children: habits.map((habit) {
        return HabitListTile(
          leading: Icon(habitIcons[habit.iconId], color: kTextBaseColorBlack),
          title: Text(
            habit.title,
            style: const TextStyle(color: kTextBaseColorBlack),
          ),
          subtitle: Text(
            habit.goal == null ? '' : habit.goal!.title,
            style: const TextStyle(color: kTextBaseColorBlack),
          ),
          backgroundColor: kTextBaseColor,
          downColor: kLightGray8,
          height: 75,
          onTap: () async {
            await routeManager.push(
              context,
              HabitRecordScreen(
                habit: habit,
                popLabel: HugeIcons.strokeRoundedUserMultiple,
                readOnly: true,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: _buildPanel(
        context,
        screenWidth,
        screenHeight,
        partnerSnapshot.data!.docs[0].data()['username'].toString(),
        kDarkGray,
        [
          _buildHabitsSection(
            context,
            partnerSnapshot.data!.docs.first.id,
          ),
        ],
      ),
    );
  }
}
