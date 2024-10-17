import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    super.key,
    required this.onLogout,
  });

  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: const Icon(
        HugeIcons.strokeRoundedLogoutCircle01,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.center,
      onTap: () async {
        await onLogout();
      },
      mainItem: [
        Text(
          TextContents.logout.text,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
