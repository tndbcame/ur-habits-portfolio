import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';

class ChangeUsernameTile extends StatelessWidget {
  const ChangeUsernameTile({super.key, required this.onUsernameChange});
  final Future<void> Function() onUsernameChange;

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: const Icon(
        HugeIcons.strokeRoundedEdit02,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.center,
      isFirst: true,
      useArrow: true,
      onTap: () async {
        await onUsernameChange();
      },
      mainItem: [
        Text(
          TextContents.updateUsername.text,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
