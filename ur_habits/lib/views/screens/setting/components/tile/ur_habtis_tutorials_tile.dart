import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';

class UrHabtisTutorialsTile extends StatelessWidget {
  const UrHabtisTutorialsTile({
    super.key,
    required this.routeManager,
    this.isFinal = false,
  });

  final RouteManager routeManager;
  final bool isFinal;

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: const Icon(
        HugeIcons.strokeRoundedTeaching,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.center,
      isFinal: isFinal,
      useArrow: true,
      onTap: () async {
        await routeManager.showTutorial(context);
      },
      mainItem: [
        Text(
          TextContents.tutorial.text,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
