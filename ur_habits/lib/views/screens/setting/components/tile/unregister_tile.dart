import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';
import 'package:ur_habits/views/screens/auth/unregisters.dart';

class UnregisterTile extends StatelessWidget {
  const UnregisterTile({
    super.key,
    required this.routeManager,
    //  required this.firebaseViewModel,
  });

  final RouteManager routeManager;
  // final FirebaseViewModel firebaseViewModel;

  /// 退会画面への遷移処理
  Future<void> _navigateToUnregisterScreen(BuildContext context) async {
    // await routeManager.push<UnregisterScreen>(
    //   context,
    //   UnregisterScreen(
    //     routeManager: routeManager,
    //     firebaseViewModel: firebaseViewModel,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: const Icon(
        HugeIcons.strokeRoundedUserBlock01,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.center,
      useArrow: true,
      isFinal: true,
      onTap: () async {
        await _navigateToUnregisterScreen(context);
      },
      mainItem: [
        Text(
          TextContents.confirmWithdrawalAction.text,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
