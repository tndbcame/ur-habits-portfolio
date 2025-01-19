// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_habits/data/services/firebase_service.dart';
import 'package:ur_habits/data/services/isar_accesser.dart';
import 'package:ur_habits/data/repositories/isar_repository.dart';
import 'package:ur_habits/routers/router.dart';
import 'package:ur_habits/utils/ads/ad_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
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
      apiKey: 'dummy-api-key',
      appId: '1:1234567890:android:dummyappid',
      messagingSenderId: '1234567890',
      projectId: 'your-project-id',
    ),
  );

  // Firebaseエミュレータの設定
  FirebaseService service = FirebaseService();
  await service.auth.useAuthEmulator('127.0.0.1', 9099);
  service.firestore.settings = const Settings(
    host: '10.0.2.2:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  // テスト用のユーザーを登録する
  await registerTestUser(service, 'a@ur-habi.com', 'aaaaaa', 'taro');
  await registerTestUser(service, 'b@ur-habi.com', 'bbbbbb', 'hanako');

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

/// テストユーザーを登録する
Future<void> registerTestUser(
    FirebaseService service, String email, String password, String name) async {
  final signInMethods = await service.auth.fetchSignInMethodsForEmail(email);
  if (signInMethods.isEmpty) {
    await service.registerUser(email, password);
    final FirebaseViewModel firebaseViewModel = FirebaseViewModel();
    await firebaseViewModel.setUserInfo(
        firebaseViewModel.getUid(), name, email);
    await service.logout();
  }
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
