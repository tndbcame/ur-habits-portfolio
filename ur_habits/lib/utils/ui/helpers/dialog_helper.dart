import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/selecting_caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/description_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/star_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/time_dialog.dart';

class DialogHelper {
  /// ダイアログを表示する
  static Future<T?> showDialogs<T>(BuildContext context, Widget dialog) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
    );
  }

  /// ユーザーに選択を求めるダイアログを表示
  static Future<bool?> showSelectDialog(
    BuildContext context,
    String message,
    String buttonText,
    Color color,
  ) async {
    return await showAnimationDialog<bool>(
      context,
      SelectingCautionDialog(
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
    String message,
  ) async {
    await showAnimationDialog(
      context,
      CautionDialog(
        message: message,
        messageFontSize: 16,
        confirmButtonColor: Theme.of(context).primaryColor,
        onConfirm: () {
          context.pop();
        },
      ),
      animaType: 1,
    );
  }

  /// 警告ダイアログを表示する
  static Future<void> showDescriptionDialog(
    BuildContext context,
    List<Widget> messages,
  ) async {
    await showAnimationDialog(
      context,
      DescriptionDialog(
        messages: messages,
      ),
      animaType: 1,
    );
  }

  /// アニメーションをしてダイアログを表示する
  static Future<T?> showAnimationDialog<T>(
    BuildContext context,
    Widget dialog, {
    int animaType = 1,
  }) {
    if (animaType == 1) {
      // 拡大しながらダイアログを表示させる
      return showGeneralDialog(
          barrierColor: kTextBaseColorBlack.applyOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(opacity: a1.value, child: dialog),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) => const SizedBox());
    } else if (animaType == 2) {
      return showGeneralDialog(
        // 下に動きながらダイアログを表示させる
        barrierColor: kTextBaseColorBlack.applyOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(opacity: a1.value, child: dialog),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const SizedBox(),
      );
    } else {
      return showGeneralDialog(
          barrierColor: kTextBaseColorBlack.applyOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return FadeTransition(
                opacity: CurvedAnimation(parent: a1, curve: Curves.easeIn),
                child: dialog);
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) => const SizedBox());
    }
  }

  /// 時間入力ダイアログを表示する
  static Future<(Duration, String, DateTime?)?> showTimePicker(
    BuildContext context,
    DataType dataType,
    int accumulationType, {
    Map<DateTime, Duration>? values,
    Duration? initialValue,
    void Function(BuildContext context, DateTime date)? onDelete,
    DateTime? date,
  }) async {
    // データタイプがID 4の場合、秒を使用する
    bool isSecond = dataType.id == 4;
    // キーボードを隠す
    _hideKeyboard(context);
    // ダイアログを表示
    (Duration, DateTime?)? result =
        await showAnimationDialog<(Duration, DateTime?)>(
      context,
      TimeDialog(
        dialogTitle: dataType.name,
        unit: dataType.unit,
        hourSize: accumulationType == 1 ? 1000 : 24,
        isSecond: isSecond,
        values: values,
        val: initialValue,
        onDelete: onDelete,
        date: date,
      ),
    );
    if (result == null) return null;
    // 表示用の時間文字列を生成
    String displayValue =
        UITrimmer.formatTime(result.$1, includeSeconds: isSecond);
    return (result.$1, displayValue, result.$2);
  }

  /// スター入力ダイアログを表示する
  static Future<(String, DateTime?)?> showStarPicker(
    BuildContext context,
    DataType dataType, {
    Map<DateTime, String>? values,
    String? initialValue,
    void Function(BuildContext context, DateTime date)? onDelete,
    DateTime? date,
  }) async {
    // 初期値を設定
    double? initVal;
    if (initialValue != null) {
      initVal = initialValue.isEmpty ? 0 : double.parse(initialValue);
    }

    // キーボードを隠す
    _hideKeyboard(context);
    // ダイアログを表示
    (String, DateTime?)? result =
        await showAnimationDialog<(String, DateTime?)>(
      context,
      StarDialog(
        dialogTitle: dataType.name,
        values: values,
        val: initVal,
        onDelete: onDelete,
        date: date,
      ),
    );
    return result;
  }

  /// キーボードを隠す
  static void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
