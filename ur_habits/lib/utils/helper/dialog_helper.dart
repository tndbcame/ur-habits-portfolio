import 'package:flutter/material.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/selecting_caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/description_dialog.dart';

class DialogHelper {
  /// ユーザーに選択を求めるダイアログを表示
  static Future<bool?> showSelectDialog(
    BuildContext context,
    RouteManager routeManager,
    String message,
    String buttonText,
    Color color,
  ) async {
    return await routeManager.showAnimationDialog<bool>(
      context,
      SelectingCautionDialog(
        routeManager: routeManager,
        message: message,
        messageFontSize: 16,
        confirmButtonColor: color,
        confirmButtonText: buttonText,
      ),
      animaType: 1,
    );
  }

  /// 警告ダイアログを表示する
  static Future<void> showCautionDialog(
    BuildContext context,
    RouteManager routeManager,
    String message,
  ) async {
    await routeManager.showAnimationDialog(
      context,
      CautionDialog(
        message: message,
        messageFontSize: 16,
        confirmButtonColor: Theme.of(context).primaryColor,
        onConfirm: () {
          routeManager.pop(context);
        },
      ),
      animaType: 1,
    );
  }

  /// 警告ダイアログを表示する
  static Future<void> showDescriptionDialog(
    BuildContext context,
    RouteManager routeManager,
    List<Widget> messages,
  ) async {
    await routeManager.showAnimationDialog(
      context,
      DescriptionDialog(
        routeManager: routeManager,
        messages: messages,
      ),
      animaType: 1,
    );
  }
}
