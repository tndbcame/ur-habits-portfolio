import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';

class AchievementGraph extends StatelessWidget {
  const AchievementGraph({
    super.key,
    required this.accumulatedValue,
    required this.achievementRate,
    required this.targetValue,
  });

  final String accumulatedValue;
  final double achievementRate;
  final String targetValue;

  /// 円グラフのセクションを作成する
  List<PieChartSectionData> _buildPieChartSections(BuildContext context) {
    return [
      PieChartSectionData(
        color: Theme.of(context).primaryColor,
        value: (100 - achievementRate) >= 100 ? 0 : achievementRate,
        titlePositionPercentageOffset: 0.7,
        title: '',
        titleStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        radius: 25,
      ),
      PieChartSectionData(
        color: kThirdBaseColor,
        value: (100 - achievementRate) <= 0 ? 0 : 100 - achievementRate,
        title: '',
        titlePositionPercentageOffset: 0.8,
        radius: 25,
      ),
    ];
  }

  /// グラフ下のテキストを生成する
  Widget _buildTextRow(String label, String value, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.35,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: kTextBaseColorBlack,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.35,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: kTextBaseColorBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 240,
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 270,
                  sections: _buildPieChartSections(context),
                  sectionsSpace: 0,
                  centerSpaceRadius: 90,
                ),
              ),
              Center(
                child: Text(
                  '$achievementRate%',
                  style: const TextStyle(
                    fontSize: 20,
                    color: kSecondBaseColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildTextRow(
            TextContents.goalValuePrefix.text, targetValue, screenWidth),
        _buildTextRow(TextContents.cumulativeValuePrefix.text, accumulatedValue,
            screenWidth),
      ],
    );
  }
}
