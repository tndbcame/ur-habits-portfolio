## ⚪︎ 概要

このアプリ (UrHabits) は、習慣化と目標達成を支援するモバイルアプリです。Flutterを使用しており、Google Playストアにリリース済みです。ユーザーが日々の習慣を管理し、モチベーションを保ちながら目標達成に向けた進捗を追跡できることを目的としています。

主要な機能として、習慣の追加・更新・削除、習慣の記録、友人や恋人などの「パートナー」との習慣共有機能を提供し、データはFirebaseとローカルDB (isar) に保存されます。さらに、テーマカラーの変更や、AdMobを利用した広告の表示機能も実装しました。

アプリのURLはこちらになります。  
[https://play.google.com/store/apps/details?id=dev.dt.urHabits&hl=ja](https://play.google.com/store/apps/details?id=dev.dt.urHabits&hl=ja)

## ⚪︎ 主な機能

- **習慣の作成、更新、削除**  
  ローカルDBとFirebaseに対応
- **習慣記録の作成、更新、削除**  
  ローカルDBとFirebaseに対応
- **ログイン機能**  
  ユーザーアカウントの作成、ログイン、ログアウト
- **アカウント情報の更新**  
  ユーザー名やパスワードの変更
- **退会機能**  
  アカウントに関する情報を削除が可能
- **パートナー機能**  
  一人のパートナーと習慣を共有
- **テーマカラー変更**  
  アプリのテーマカラーを変更
- **習慣の進捗確認**  
  円グラフやカレンダーを使って進捗を可視化

## ⚪︎ 画面

| 習慣一覧画面                                                                                                        | 習慣追加画面                                                                                                     |
| ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| ![習慣一覧画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296279.png)     | ![習慣追加画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296290.png)      |
| 現在登録されている習慣の一覧を確認し、新しい習慣の追加や、編集マークをタップして編集・削除ができます。                          | 習慣の詳細を入力して新しい習慣を作成できます。習慣のタイトル、カテゴリなどあなたの習慣に適した設定をすることができます。      |

| 目標設定画面                                                                                                     | パートナーの習慣一覧画面                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| ![目標設定画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296293.png) | ![パートナーの習慣一覧画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296298.png)      |
| 前画面で設定した習慣に対して目標を設定することができます。期日、目標値などあなたに適した目標を設定することできます。                    | パートナーの習慣を確認できる画面となっています。習慣をタップして習慣記録を確認できます。          |

| 記録画面(カレンダー)                                                                                                       | 記録画面(目標達成_グラフ)                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![記録画面(カレンダー)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296304.png)       | ![記録画面(目標達成_グラフ)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296323.png)   |
| カレンダー形式で習慣の達成状況を可視化します。記録した日はチェックがつくため、一目で進捗状況を確認できます。                                | 円グラフを使用して、習慣の達成率や進捗をグラフで表示します。視覚的に進捗状況を把握できます。             |

| 記録画面(目標達成_グラフなし)                                                                                                      | 設定画面                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![記録画面(目標達成_グラフなし)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296306.png)       | ![設定画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296329.png)         |
| 円グラフを表示しないで目標値のみを表示する画面です。              | アプリの設定画面です。テーマカラーの変更やアカウント関係の情報の設定ができます。                          |

| タイトル画面                                                                                                 | 新規アカウント作成画面                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![タイトル画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296334.png) | ![新規アカウント作成画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296339.png)            |
| アプリのタイトル画面です。ログインや新規アカウント作成を選択できる画面です。                 | アカウントを新規で作成することができる画面です。           |

| ログイン画面                                                                                             | チュートリアル                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![ログイン画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296342.png) | ![チュートリアル](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296349.png)        |
| 作成したアカウントを用いてログインができる画面です。               | このアプリのチュートリアルを表示することができる画面です。                                          |

| 各画面の説明                                                                                             | 習慣記録(整数)                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![各画面の説明](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296362.png) | ![習慣記録(整数)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296394.png)        |
| 各画面で操作方法や項目の説明をダイアログで表示します。               | データタイプを整数にしたときの習慣の記録をするときのダイアログです。                                          |

| 習慣記録(時間(分))                                                                                             | 習慣記録(時間(秒))                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![ログイン画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296415.png) | ![習慣記録(時間(秒))](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296434.png)        |
| データタイプを時間(分)にしたときの習慣の記録をするときのダイアログです。               | データタイプを習慣記録(時間(秒)にしたときの習慣の記録をするときのダイアログです。                                          |

| 習慣記録(チェックボックス)                                                                                             | 習慣記録(５段階評価)                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| ![習慣記録(チェックボックス)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296449.png) | ![チュートリアル](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296466.png)        |
| データタイプをチェックボックスにしたときの習慣の記録をするときのダイアログです。               | データタイプを５段階評価にしたときの習慣の記録をするときのダイアログです。                                          |

| 習慣記録(カウンター)                                                                                             | 
| ------------------------------------------------------------------------------------------------------------------ | 
| ![習慣記録(カウンター)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296482.png) | 
| データタイプをカウンターにしたときの習慣の記録をするときのダイアログです。               | 

## ⚪︎ 使用技術

- `firebase_core: ^3.3.0`
- `firebase_auth: ^5.1.4`
- `cloud_firestore: ^5.2.1`
- `isar: ^3.1.0+1`
- `isar_flutter_libs: ^3.1.0+1`
- `isar_generator: ^3.1.0+1`
- `flutter_riverpod: ^2.5.1`
- `riverpod_annotation: ^2.3.5`
- `riverpod_generator: ^2.3.3`
- `riverpod_lint: ^2.1.1`
- `shared_preferences: ^2.3.2`
- `path_provider: ^2.1.4`
- `connectivity_plus: ^6.0.5`
- `intl: ^0.19.0`
- `uuid: ^4.4.2`
- `google_fonts: ^6.2.1`
- `cupertino_icons: ^1.0.8`
- `flutter_rating_bar: ^4.0.1`
- `fl_chart: ^0.68.0`
- `community_material_icon: ^5.9.55`
- `hugeicons: ^0.0.7`
- `flutter_overboard: ^3.1.3`
- `url_launcher: ^6.3.0`
- `google_mobile_ads: ^5.1.0`
- `flutter_launcher_icons: ^0.14.1`
- `flutter_lints: ^4.0.0`
- `build_runner: ^2.4.12`
- `custom_lint: ^0.5.11`

## ⚪︎ フォルダ構成

```markdown
├── data
│   ├── models                // アプリのデータモデルを定義
│   ├── repositories          // データの取得・保存などを管理するリポジトリ
│   └── services              // FirebaseやIsarなどのサービス連携
├── firebase_options.dart     // Firebaseの設定ファイル
├── main.dart                 // アプリのエントリーポイント
├── resources
│   ├── colors.dart           // カラーテーマの設定
│   ├── data.dart             // アプリ内の固定データ
│   └── extension             // 拡張メソッドを定義(アプリの文言等はここで管理)
├── routers                   // ルーティングの管理
├── utils
│   ├── helper                // 各種ヘルパークラス
│   └── ui                    // UI関連のヘルパーとバリデーション
├── view_models
│   ├── mappers               // データ変換ロジック
│   └── providers             // 状態管理を行うプロバイダー
└── views
├── components            // 共通UIコンポーネント
└── screens               // 画面ごとのUI定義
```

## ⚪︎ ステップ数

## Languages
| language | files | code | comment | blank | total |
| :--- | ---: | ---: | ---: | ---: | ---: |
| Dart | 128 | 16,342 | 611 | 1,566 | 18,519 |

## Directories
| path | files | code | comment | blank | total |
| :--- | ---: | ---: | ---: | ---: | ---: |
| . | 128 | 16,342 | 611 | 1,566 | 18,519 |
| . (Files) | 2 | 95 | 18 | 10 | 123 |
| data | 16 | 4,822 | 125 | 549 | 5,496 |
| data/models | 12 | 3,767 | 24 | 429 | 4,220 |
| data/models (Files) | 8 | 3,691 | 24 | 422 | 4,137 |
| data/models/ui | 4 | 76 | 0 | 7 | 83 |
| data/repositories | 2 | 930 | 79 | 96 | 1,105 |
| data/services | 2 | 125 | 22 | 24 | 171 |
| resources | 5 | 826 | 16 | 32 | 874 |
| resources (Files) | 2 | 328 | 1 | 13 | 342 |
| resources/extension | 3 | 498 | 15 | 19 | 532 |
| routers | 1 | 144 | 18 | 10 | 172 |
| utils | 9 | 449 | 54 | 69 | 572 |
| utils (Files) | 1 | 45 | 7 | 6 | 58 |
| utils/helper | 3 | 174 | 10 | 22 | 206 |
| utils/helper (Files) | 1 | 58 | 3 | 4 | 65 |
| utils/helper/ads | 2 | 116 | 7 | 18 | 141 |
| utils/ui | 5 | 230 | 37 | 41 | 308 |
| utils/ui (Files) | 2 | 81 | 20 | 27 | 128 |
| utils/ui/validators | 3 | 149 | 17 | 14 | 180 |
| view_models | 10 | 746 | 85 | 120 | 951 |
| view_models (Files) | 2 | 332 | 55 | 57 | 444 |
| view_models/mappers | 5 | 171 | 0 | 20 | 191 |
| view_models/providers | 3 | 243 | 30 | 43 | 316 |
| views | 85 | 9,260 | 295 | 776 | 10,331 |
| views/components | 26 | 2,595 | 79 | 239 | 2,913 |
| views/components/Indicator | 1 | 15 | 0 | 4 | 19 |
| views/components/button | 5 | 401 | 0 | 50 | 451 |
| views/components/calender | 2 | 440 | 24 | 45 | 509 |
| views/components/dialog | 15 | 1,578 | 55 | 128 | 1,761 |
| views/components/dialog (Files) | 1 | 61 | 0 | 3 | 64 |
| views/components/dialog/caution_dialog | 4 | 281 | 10 | 25 | 316 |
| views/components/dialog/caution_dialog (Files) | 2 | 180 | 3 | 11 | 194 |
| views/components/dialog/caution_dialog/overlay | 2 | 101 | 7 | 14 | 122 |
| views/components/dialog/input_dialog | 10 | 1,236 | 45 | 100 | 1,381 |
| views/components/dialog/input_dialog (Files) | 7 | 993 | 33 | 80 | 1,106 |
| views/components/dialog/input_dialog/button | 1 | 66 | 3 | 7 | 76 |
| views/components/dialog/input_dialog/controller | 1 | 33 | 5 | 6 | 44 |
| views/components/dialog/input_dialog/tile | 1 | 144 | 4 | 7 | 155 |
| views/components/text | 2 | 43 | 0 | 5 | 48 |
| views/components/tile | 1 | 118 | 0 | 7 | 125 |
| views/screens | 59 | 6,665 | 216 | 537 | 7,418 |
| views/screens/auth | 9 | 1,183 | 46 | 93 | 1,322 |
| views/screens/auth (Files) | 5 | 966 | 45 | 77 | 1,088 |
| views/screens/auth/components | 4 | 217 | 1 | 16 | 234 |
| views/screens/auth/components/button | 1 | 46 | 0 | 3 | 49 |
| views/screens/auth/components/container | 1 | 31 | 0 | 4 | 35 |
| views/screens/auth/components/form | 1 | 91 | 0 | 5 | 96 |
| views/screens/auth/components/tile | 1 | 49 | 1 | 4 | 54 |
| views/screens/habit_detail | 18 | 1,736 | 58 | 147 | 1,941 |
| views/screens/habit_detail (Files) | 4 | 969 | 42 | 73 | 1,084 |
| views/screens/habit_detail/components | 14 | 767 | 16 | 74 | 857 |
| views/screens/habit_detail/components/form | 2 | 114 | 4 | 12 | 130 |
| views/screens/habit_detail/components/tile | 12 | 653 | 12 | 62 | 727 |
| views/screens/habit_detail/components/tile (Files) | 2 | 172 | 10 | 20 | 202 |
| views/screens/habit_detail/components/tile/goal_detail | 4 | 150 | 2 | 18 | 170 |
| views/screens/habit_detail/components/tile/habit_detail | 6 | 331 | 0 | 24 | 355 |
| views/screens/habit_record | 11 | 1,138 | 35 | 102 | 1,275 |
| views/screens/habit_record (Files) | 1 | 439 | 12 | 38 | 489 |
| views/screens/habit_record/components | 9 | 653 | 18 | 57 | 728 |
| views/screens/habit_record/components/graph | 2 | 205 | 11 | 19 | 235 |
| views/screens/habit_record/components/panel | 3 | 116 | 0 | 11 | 127 |
| views/screens/habit_record/components/section | 2 | 154 | 0 | 8 | 162 |
| views/screens/habit_record/components/tile | 1 | 88 | 4 | 10 | 102 |
| views/screens/habit_record/components/toggle | 1 | 90 | 3 | 9 | 102 |
| views/screens/habit_record/helper | 1 | 46 | 5 | 7 | 58 |
| views/screens/setting | 8 | 636 | 11 | 51 | 698 |
| views/screens/setting (Files) | 1 | 318 | 8 | 23 | 349 |
| views/screens/setting/components | 7 | 318 | 3 | 28 | 349 |
| views/screens/setting/components/tile | 7 | 318 | 3 | 28 | 349 |
| views/screens/tabs | 12 | 1,814 | 61 | 135 | 2,010 |
| views/screens/tabs (Files) | 1 | 288 | 8 | 22 | 318 |
| views/screens/tabs/components | 7 | 916 | 38 | 74 | 1,028 |
| views/screens/tabs/components/drawer | 4 | 599 | 16 | 36 | 651 |
| views/screens/tabs/components/drawer (Files) | 1 | 280 | 8 | 12 | 300 |
| views/screens/tabs/components/drawer/panel | 3 | 319 | 8 | 24 | 351 |
| views/screens/tabs/components/panel | 2 | 192 | 12 | 21 | 225 |
| views/screens/tabs/components/tile | 1 | 125 | 10 | 17 | 152 |
| views/screens/tabs/home_tab | 2 | 347 | 7 | 24 | 378 |
| views/screens/tabs/home_tab (Files) | 1 | 195 | 3 | 16 | 214 |
| views/screens/tabs/home_tab/components | 1 | 152 | 4 | 8 | 164 |
| views/screens/tabs/partner_tab | 2 | 263 | 8 | 15 | 286 |
| views/screens/tabs/partner_tab (Files) | 1 | 91 | 3 | 6 | 100 |
| views/screens/tabs/partner_tab/components | 1 | 172 | 5 | 9 | 186 |
| views/screens/tutorial | 1 | 158 | 5 | 9 | 172 |

上記はVSCodeCounterで数えたものになります。.gファイル(自動生成ファイル)などを引いたステップ数は全体で14447コードだけだと12704です。

## ⚪︎ 今後の展望

今後はパートナーの登録数や公開できる習慣数を機能の拡張をしていけたらと思います。またmodelやview_modelは冗長な部分が多いため、リファクタリングやライブラリを導入してより、管理しやすい拡張性のあるアプリにしていきたいと思います。