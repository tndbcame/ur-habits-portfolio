import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/screens/tabs/components/tile/habit_list_tile.dart';

class PartnerDetailsPanel extends StatelessWidget {
  const PartnerDetailsPanel({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.partnerData,
    required this.firebaseViewModel,
  });

  final double screenWidth;
  final double screenHeight;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> partnerData;
  final FirebaseViewModel firebaseViewModel;

  /// パネルを構築する
  Widget _buildPanel(
    BuildContext context,
    double screenWidth,
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
      stream: firebaseViewModel.getPartnerHabits(partnerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildNoDataMessage();
        } else {
          return _buildHabitListView(context, snapshot.data!);
        }
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
            await context.push(
              RouterEnums.habitRecord.paths,
              extra: HabitRecordsData(
                habit: habit,
                ishome: false,
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
    return Column(
      children: [
        for (final doc in partnerData) ...{
          SizedBox(
            height: screenHeight * 0.375,
            width: screenWidth,
            child: _buildPanel(
              context,
              screenWidth,
              doc.data()['username'].toString(),
              kDarkGray,
              [
                _buildHabitsSection(
                  context,
                  doc.id,
                ),
              ],
            ),
          ),
        }
      ],
    );
  }
}
