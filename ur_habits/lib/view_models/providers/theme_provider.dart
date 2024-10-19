import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ur_habits/resources/colors.dart';

const Map<String, Color> baseColorMap = {
  'BLUE': Color(0xFF6dbbd9),
  'GREEN': Color(0xFF6dd9b6),
  'RED': Color(0xFFd9736d),
  'YELLOW': Color(0xFFd9c46d),
  'PURPLE': Color(0xFF826dd9),
};

const String baseColorKey = 'baseColorKey';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_buildTheme()) {
    _loadTheme();
  }

  /// 現在にカラーのキー
  String? currentColorKey;

  /// 初期テーマ設定
  static ThemeData _buildTheme() {
    return ThemeData(
      splashColor: Colors.transparent,
      textTheme: GoogleFonts.bizUDGothicTextTheme(),
      primaryColor: kThirdBaseColor,
    );
  }

  /// カスタムテーマを設定
  Future<void> setTheme({String? colorKey}) async {
    currentColorKey = colorKey;
    final selectedColor = baseColorMap[colorKey] ?? baseColorMap['BLUE'];
    state = state.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: selectedColor ?? kThirdBaseColor,
      ),
      primaryColor: selectedColor,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(baseColorKey, colorKey ?? 'BLUE');
  }

  /// 保存されたテーマを読み込む
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedColorKey = prefs.getString(baseColorKey);
    await setTheme(colorKey: savedColorKey);
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
