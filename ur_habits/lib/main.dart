// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ur_habits/firebase_options.dart';
import 'package:ur_habits/data/services/isar_accesser.dart';
import 'package:ur_habits/data/repositories/isar_repository.dart';
import 'package:ur_habits/utils/helper/ads/ad_helper.dart';
import 'package:ur_habits/view_models/providers/theme_provider.dart';
import 'package:ur_habits/views/screens/tabs/tabs.dart';

void main() async {
  //アプリの方向を縦方向のみ許可(縦向きで固定)
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // isarの初期化
  await IsarAccessor().initialize();
  // firebase初期化
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // 広告の初期化
  await AdHelper.initGoogleMobileAds();

  //　ローカルDBの初期化処理（デバック用に作成）
  final repository = IsarRepository(isar: IsarAccessor().isar);
  repository.clearData(isClear: true); //DB初期化するときはここをisInitをtrueにする

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在のテーマを取得
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
