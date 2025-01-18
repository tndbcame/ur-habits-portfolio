import 'package:flutter/material.dart';

class BottomSheetHelper {
  /// ボトムシートを表示する
  static Future<T?> showBottomSheet<T>(
      BuildContext context, Widget bottomSheet) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => bottomSheet,
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}
