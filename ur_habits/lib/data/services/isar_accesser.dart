import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/init.dart';

/// Isarデータベースへのアクセスを管理するクラス
class IsarAccessor {
  /// シングルトンで実装
  static final IsarAccessor _instance = IsarAccessor._internal();
  IsarAccessor._internal();
  factory IsarAccessor() {
    return _instance;
  }

  /// Isarインスタンス
  late final Isar _isar;

  /// Isarインスタンスを取得するゲッター
  Isar get isar => _isar;

  /// 初期化処理を行う
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final directoryPath = await _getDirectoryPath();
    await _openIsar(directoryPath);
  }

  /// ディレクトリのパスを取得する
  Future<String> _getDirectoryPath() async {
    if (kIsWeb) {
      return '';
    } else {
      final directory = await getApplicationSupportDirectory();
      return directory.path;
    }
  }

  /// Isarデータベースを開く
  Future<void> _openIsar(String path) async {
    _isar = await Isar.open(
      [
        HabitSchema,
        HabitRecordSchema,
        HabitGoalSchema,
        InitSchema,
      ],
      directory: path,
    );
  }
}
