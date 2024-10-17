import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class HabitTypeTile extends StatelessWidget {
  const HabitTypeTile({
    super.key,
    required this.userStream,
    required this.habitType,
    required this.onTapHabitType,
    required this.showOverlayDialog,
  });

  final Stream<User?> userStream;
  final int habitType;
  final VoidCallback onTapHabitType;
  final void Function(BuildContext, String) showOverlayDialog;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HabitDetailListTile(
            title: TextContents.habitType.text,
            itemHeight: 80,
            onTap: onTapHabitType,
            mainItem: Expanded(
              child: Text(
                habitType == 1
                    ? TextContents.habitTypePrivate.text
                    : TextContents.habitTypePublic.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        }
        return HabitDetailListTile(
          title: TextContents.habitType.text,
          itemHeight: 80,
          isRequiredMark: true,
          mainItem: Expanded(
            child: Text(
              TextContents.habitTypePrivate.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextThirdBaseColor,
              ),
            ),
          ),
          onTap: () {
            showOverlayDialog(
              context,
              TextContents.loginRequiredToChangeHabitType.text,
            );
          },
        );
      },
    );
  }
}
