import 'package:flutter/material.dart';

class UIHelper {
  static double calcScreenSize(double totalHeight, double statusBarHeight) {
    double appBarHeight = AppBar().preferredSize.height; // AppBarの高さ
    double bottomNavigationBarHeight = kBottomNavigationBarHeight; // TabBarの高さ

// AppBar, TabBar, ステータスバーを引いた残りの高さ
    double availableHeight = totalHeight -
        appBarHeight -
        bottomNavigationBarHeight -
        statusBarHeight;
    return availableHeight;
  }

  /// キーボードが表示されているか確認する
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  /// キーボードを閉じる処理
  static Future<void> closeKeyboard(BuildContext context) async {
    FocusScope.of(context).unfocus();
  }
}
