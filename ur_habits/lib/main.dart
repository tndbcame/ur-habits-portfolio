import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_habits/data/services/isar_accesser.dart';
import 'package:ur_habits/data/repositories/isar_repository.dart';
import 'package:ur_habits/routers/router.dart';
import 'package:ur_habits/utils/ads/ad_helper.dart';
import 'package:ur_habits/view_models/providers/theme_provider.dart';

void main() async {
  // アプリの方向を縦方向のみ許可 (縦向きで固定)
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Isarの初期化
  await IsarAccessor().initialize();

  // Firebase初期化 (エミュレータ用)
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'dummy-api-key', // ダミー値
      appId: '1:1234567890:android:dummyappid', // ダミー値
      messagingSenderId: '1234567890', // ダミー値
      projectId: 'your-project-id', // プロジェクトIDを設定
    ),
  );

  // Firebaseエミュレータの設定
  FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099); // Authentication
  FirebaseFirestore.instance.settings = const Settings(
    host: '127.0.0.1:8080', // Firestore
    sslEnabled: false,
    persistenceEnabled: false,
  );

  // 広告の初期化
  await AdHelper.initGoogleMobileAds();

  // ローカルDBの初期化処理 (デバッグ用)
  final repository = IsarRepository(isar: IsarAccessor().isar);
  repository.clearData(isClear: false); // DBを初期化する場合はisClearをtrueに設定

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
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
