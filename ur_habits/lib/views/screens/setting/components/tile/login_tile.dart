import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';

import 'package:ur_habits/views/components/tile/auth_list_tile.dart';

class LoginTile extends StatelessWidget {
  const LoginTile({super.key});

  /// タイトル画面への遷移処理
  Future<void> _navigateToTitleScreen(BuildContext context) async {
    await context.push(RouterEnums.title.paths, extra: TitlesData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthListTile(
          title: const Icon(
            HugeIcons.strokeRoundedLoginCircle01,
            color: kTextThirdBaseColor,
          ),
          itemHeight: 70,
          itemWidth: double.infinity,
          mainAxisAlignment: MainAxisAlignment.center,
          isFirst: true,
          onTap: () async {
            await _navigateToTitleScreen(context);
          },
          mainItem: [
            Text(
              TextContents.login.text,
              style: const TextStyle(
                fontSize: 16,
                color: kTextThirdBaseColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
