## ⚪︎ 目次
- [⚪︎ 目次](#︎-目次)
- [⚪︎ 概要](#︎-概要)
- [⚪︎ 主な機能](#︎-主な機能)
- [⚪︎ 画面](#︎-画面)
- [⚪︎ 使用技術](#︎-使用技術)
  - [**Firebase 関連**](#firebase-関連)
  - [**ローカルデータベース**](#ローカルデータベース)
  - [**状態管理**](#状態管理)
  - [**UI 関連**](#ui-関連)
  - [**開発ツール**](#開発ツール)
  - [**その他**](#その他)
- [⚪︎ フォルダ構成](#︎-フォルダ構成)
- [⚪︎ ステップ数](#︎-ステップ数)
  - [**Languages**](#languages)
  - [**Directories**](#directories)
- [⚪︎ 本ポートフォリオにおけるアプリ起動方法](#︎-本ポートフォリオにおけるアプリ起動方法)
- [⚪︎ 今後の展望](#︎-今後の展望)


## ⚪︎ 概要

このアプリ (UrHabits) は、習慣化と目標達成を支援するモバイルアプリです。Flutterを使用しており、Google Play Store、App Storeにリリース済みです。ユーザーが日々の習慣を管理し、モチベーションを保ちながら目標達成に向けた進捗を追跡できることを目的としています。

主要な機能として、習慣の追加・更新・削除、習慣の記録、友人や恋人などの「パートナー」との習慣共有機能を提供し、データはFirebaseとローカルDB (isar) に保存されます。さらに、テーマカラーの変更や、AdMobを利用した広告の表示機能も実装しました。

※このポートフォリオに掲載されているコードは、Firebaseのセキュリティに関するファイルを含めることができないため、一部機能は制限(firebaseに関係ある処理)されています。(本ポートフォリオでは、firebase emulatorを利用して動作している状態となります。)

リリース済みアプリのURLはこちらになります。  

【Android】
[https://play.google.com/store/apps/details?id=dev.dt.urHabits&hl=ja](https://play.google.com/store/apps/details?id=dev.dt.urHabits&hl=ja)

【ios】
[https://apps.apple.com/us/app/習慣管理アプリ-urhabits-目標達成-共有機能付き/id6740855436](https://apps.apple.com/us/app/習慣管理アプリ-urhabits-目標達成-共有機能付き/id6740855436)


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

| 習慣一覧画面                                                                                                | 習慣追加画面                                                                                                             |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| ![習慣一覧画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296279.png) | ![習慣追加画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296290.png)              |
| 現在登録されている習慣の一覧を確認し、新しい習慣の追加や、編集マークをタップして編集・削除ができます。      | 習慣の詳細を入力して新しい習慣を作成できます。習慣のタイトル、カテゴリなどあなたの習慣に適した設定をすることができます。 |

| 目標設定画面                                                                                                         | パートナーの習慣一覧画面                                                                                                |
| -------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| ![目標設定画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296293.png)          | ![パートナーの習慣一覧画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296298.png) |
| 前画面で設定した習慣に対して目標を設定することができます。期日、目標値などあなたに適した目標を設定することできます。 | パートナーの習慣を確認できる画面となっています。習慣をタップして習慣記録を確認できます。                                |

| 記録画面(カレンダー)                                                                                                | 記録画面(目標達成_グラフ)                                                                                                |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| ![記録画面(カレンダー)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296304.png) | ![記録画面(目標達成_グラフ)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296323.png) |
| カレンダー形式で習慣の達成状況を可視化します。記録した日はチェックがつくため、一目で進捗状況を確認できます。        | 円グラフを使用して、習慣の達成率や進捗をグラフで表示します。視覚的に進捗状況を把握できます。                             |

| 記録画面(目標達成_グラフなし)                                                                                                | 設定画面                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| ![記録画面(目標達成_グラフなし)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296306.png) | ![設定画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296329.png) |
| 円グラフを表示しないで目標値のみを表示する画面です。                                                                         | アプリの設定画面です。テーマカラーの変更やアカウント関係の情報の設定ができます。                        |

| タイトル画面                                                                                                | 新規アカウント作成画面                                                                                                |
| ----------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| ![タイトル画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296334.png) | ![新規アカウント作成画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296339.png) |
| アプリのタイトル画面です。ログインや新規アカウント作成を選択できる画面です。                                | アカウントを新規で作成することができる画面です。                                                                      |

| ログイン画面                                                                                                | チュートリアル                                                                                                |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![ログイン画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296342.png) | ![チュートリアル](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296349.png) |
| 作成したアカウントを用いてログインができる画面です。                                                        | このアプリのチュートリアルを表示することができる画面です。                                                    |

| 各画面の説明                                                                                                | 習慣記録(整数)                                                                                                |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![各画面の説明](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296362.png) | ![習慣記録(整数)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296394.png) |
| 各画面で操作方法や項目の説明をダイアログで表示します。                                                      | データタイプを整数にしたときの習慣の記録をするときのダイアログです。                                          |

| 習慣記録(時間(分))                                                                                          | 習慣記録(時間(秒))                                                                                                |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| ![ログイン画面](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296415.png) | ![習慣記録(時間(秒))](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296434.png) |
| データタイプを時間(分)にしたときの習慣の記録をするときのダイアログです。                                    | データタイプを習慣記録(時間(秒))にしたときの習慣の記録をするときのダイアログです。                                |

| 習慣記録(チェックボックス)                                                                                                | 習慣記録(５段階評価)                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![習慣記録(チェックボックス)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296449.png) | ![チュートリアル](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296466.png) |
| データタイプをチェックボックスにしたときの習慣の記録をするときのダイアログです。                                          | データタイプを５段階評価にしたときの習慣の記録をするときのダイアログです。                                    |

| 習慣記録(カウンター)                                                                                                | ドロワーメニュー                                                                                                |
| ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| ![習慣記録(カウンター)](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1729296482.png) | ![ドロワーメニュー](https://github.com/tndbcame/ur-habits-portfolio/blob/main/images/Screenshot_1739601846.png) |
| データタイプをカウンターにしたときの習慣の記録をするときのダイアログです。                                          | パートナーを申請追加削除をするところです。右上の歯車アイコンから設定画面に遷移できます。                        |


## ⚪︎ 使用技術

### **Firebase 関連**
- `firebase_core: ^3.10.0`
- `firebase_auth: ^5.1.4`
- `cloud_firestore: ^5.2.1`

### **ローカルデータベース**
- `isar: ^3.1.0+1`
- `isar_flutter_libs: ^3.1.0+1`
- `isar_generator: ^3.1.0+1`
- `shared_preferences: ^2.3.2`
- `path_provider: ^2.1.4`

### **状態管理**
- `flutter_riverpod: ^2.5.1`
- `riverpod_annotation: ^2.3.5`
- `riverpod_generator: ^2.3.3`
- `riverpod_lint: ^2.1.1`

### **UI 関連**
- `google_fonts: ^6.2.1`
- `cupertino_icons: ^1.0.8`
- `flutter_rating_bar: ^4.0.1`
- `fl_chart: ^0.68.0`
- `community_material_icon: ^5.9.55`
- `hugeicons: ^0.0.7`
- `flutter_iconpicker: ^3.3.3`
- `go_router: ^14.6.2`

### **開発ツール**
- `flutter_lints: ^4.0.0`
- `build_runner: ^2.4.12`
- `custom_lint: ^0.5.11`
- `json_annotation: ^4.9.0`
- `json_serializable: ^6.8.0`

### **その他**
- `connectivity_plus: ^6.0.5`
- `intl: ^0.19.0`
- `uuid: ^4.4.2`
- `url_launcher: ^6.3.0`
- `google_mobile_ads: ^5.1.0`
- `flutter_launcher_icons: ^0.14.1`
- `flutter_overboard: ^3.1.3`
- `share_plus: ^10.1.3`

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
│   ├── ads                   // 広告に関する操作を行う
│   └── ui                    // UI関連のヘルパーとバリデーション
├── view_models
│   ├── mappers               // データ変換ロジック
│   └── providers             // 状態管理を行うプロバイダー
├── views
│   ├── components            // 共通UIコンポーネント
│   └── screens               // 画面ごとのUI定義
└── main                      // firebaseやローカルDB、その他初期化処理
```

## ⚪︎ ステップ数

### **Languages** 
| language | files |   code | comment | blank |  total |
| :------- | ----: | -----: | ------: | ----: | -----: |
| Dart     |   153 | 18,466 |     655 | 1,850 | 20,971 |

### **Directories**
| path                                                    | files |   code | comment | blank |  total |
| :------------------------------------------------------ | ----: | -----: | ------: | ----: | -----: |
| .                                                       |   153 | 18,466 |     655 | 1,850 | 20,971 |
| . (Files)                                               |     1 |     69 |      10 |    13 |     92 |
| data                                                    |    22 |  5,052 |     143 |   587 |  5,782 |
| data/models                                             |    16 |  3,878 |      42 |   463 |  4,383 |
| data/models (Files)                                     |     8 |  3,691 |      24 |   422 |  4,137 |
| data/models/ui                                          |     8 |    187 |      18 |    41 |    246 |
| data/repositories                                       |     4 |  1,049 |      79 |   100 |  1,228 |
| data/repositories (Files)                               |     2 |    991 |      79 |    96 |  1,166 |
| data/repositories/abstract                              |     2 |     58 |       0 |     4 |     62 |
| data/services                                           |     2 |    125 |      22 |    24 |    171 |
| resources                                               |     7 |    915 |      16 |    40 |    971 |
| resources (Files)                                       |     2 |    347 |       1 |    15 |    363 |
| resources/extension                                     |     5 |    568 |      15 |    25 |    608 |
| routers                                                 |     3 |    472 |       4 |    85 |    561 |
| utils                                                   |    12 |    605 |      69 |    86 |    760 |
| utils (Files)                                           |     3 |     71 |       8 |    15 |     94 |
| utils/ads                                               |     2 |    116 |       6 |    18 |    140 |
| utils/ui                                                |     7 |    418 |      55 |    53 |    526 |
| utils/ui (Files)                                        |     1 |     63 |      17 |    22 |    102 |
| utils/ui/helpers                                        |     3 |    206 |      21 |    17 |    244 |
| utils/ui/validators                                     |     3 |    149 |      17 |    14 |    180 |
| view_models                                             |    10 |    740 |      85 |   120 |    945 |
| view_models (Files)                                     |     2 |    326 |      55 |    57 |    438 |
| view_models/mappers                                     |     5 |    171 |       0 |    20 |    191 |
| view_models/providers                                   |     3 |    243 |      30 |    43 |    316 |
| views                                                   |    98 | 10,613 |     328 |   919 | 11,860 |
| views/components                                        |    39 |  3,950 |     105 |   359 |  4,414 |
| views/components/Indicator                              |     1 |     15 |       0 |     4 |     19 |
| views/components/bottom_sheet                           |     6 |    977 |      28 |    72 |  1,077 |
| views/components/bottom_sheet (Files)                   |     5 |    757 |      25 |    65 |    847 |
| views/components/bottom_sheet/tile                      |     1 |    220 |       3 |     7 |    230 |
| views/components/button                                 |     6 |    425 |       0 |    52 |    477 |
| views/components/calender                               |     4 |    563 |      22 |    59 |    644 |
| views/components/cursor                                 |     1 |     40 |       0 |     9 |     49 |
| views/components/dialog                                 |    15 |  1,544 |      55 |   138 |  1,737 |
| views/components/dialog (Files)                         |     1 |     60 |       0 |     4 |     64 |
| views/components/dialog/caution_dialog                  |     4 |    279 |      10 |    26 |    315 |
| views/components/dialog/caution_dialog (Files)          |     2 |    177 |       3 |    12 |    192 |
| views/components/dialog/caution_dialog/overlay          |     2 |    102 |       7 |    14 |    123 |
| views/components/dialog/input_dialog                    |    10 |  1,205 |      45 |   108 |  1,358 |
| views/components/dialog/input_dialog (Files)            |     7 |    967 |      33 |    86 |  1,086 |
| views/components/dialog/input_dialog/button             |     1 |     64 |       3 |     8 |     75 |
| views/components/dialog/input_dialog/controller         |     1 |     33 |       5 |     6 |     44 |
| views/components/dialog/input_dialog/tile               |     1 |    141 |       4 |     8 |    153 |
| views/components/scroll                                 |     2 |     38 |       0 |     8 |     46 |
| views/components/tenkey                                 |     1 |    187 |       0 |     5 |    192 |
| views/components/text                                   |     2 |     43 |       0 |     5 |     48 |
| views/components/tile                                   |     1 |    118 |       0 |     7 |    125 |
| views/screens                                           |    59 |  6,663 |     223 |   560 |  7,446 |
| views/screens/auth                                      |     9 |  1,165 |      46 |    92 |  1,303 |
| views/screens/auth (Files)                              |     5 |    948 |      45 |    76 |  1,069 |
| views/screens/auth/components                           |     4 |    217 |       1 |    16 |    234 |
| views/screens/auth/components/button                    |     1 |     46 |       0 |     3 |     49 |
| views/screens/auth/components/container                 |     1 |     31 |       0 |     4 |     35 |
| views/screens/auth/components/form                      |     1 |     91 |       0 |     5 |     96 |
| views/screens/auth/components/tile                      |     1 |     49 |       1 |     4 |     54 |
| views/screens/habit_detail                              |    18 |  1,713 |      58 |   150 |  1,921 |
| views/screens/habit_detail (Files)                      |     4 |    953 |      42 |    76 |  1,071 |
| views/screens/habit_detail/components                   |    14 |    760 |      16 |    74 |    850 |
| views/screens/habit_detail/components/form              |     2 |    114 |       4 |    12 |    130 |
| views/screens/habit_detail/components/tile              |    12 |    646 |      12 |    62 |    720 |
| views/screens/habit_detail/components/tile (Files)      |     2 |    171 |      10 |    20 |    201 |
| views/screens/habit_detail/components/tile/goal_detail  |     4 |    149 |       2 |    18 |    169 |
| views/screens/habit_detail/components/tile/habit_detail |     6 |    326 |       0 |    24 |    350 |
| views/screens/habit_record                              |    11 |  1,141 |      41 |   101 |  1,283 |
| views/screens/habit_record (Files)                      |     1 |    439 |      19 |    38 |    496 |
| views/screens/habit_record/components                   |     9 |    656 |      17 |    56 |    729 |
| views/screens/habit_record/components/graph             |     2 |    205 |      11 |    19 |    235 |
| views/screens/habit_record/components/panel             |     3 |    116 |       0 |    11 |    127 |
| views/screens/habit_record/components/section           |     2 |    160 |       0 |     8 |    168 |
| views/screens/habit_record/components/tile              |     1 |     88 |       4 |    10 |    102 |
| views/screens/habit_record/components/toggle            |     1 |     87 |       2 |     8 |     97 |
| views/screens/habit_record/helper                       |     1 |     46 |       5 |     7 |     58 |
| views/screens/setting                                   |     8 |    616 |      11 |    57 |    684 |
| views/screens/setting (Files)                           |     1 |    309 |       8 |    24 |    341 |
| views/screens/setting/components                        |     7 |    307 |       3 |    33 |    343 |
| views/screens/setting/components/tile                   |     7 |    307 |       3 |    33 |    343 |
| views/screens/tabs                                      |    12 |  1,872 |      62 |   152 |  2,086 |
| views/screens/tabs (Files)                              |     1 |    285 |       8 |    24 |    317 |
| views/screens/tabs/components                           |     7 |    981 |      39 |    86 |  1,106 |
| views/screens/tabs/components/drawer                    |     4 |    654 |      16 |    41 |    711 |
| views/screens/tabs/components/drawer (Files)            |     1 |    323 |       8 |    16 |    347 |
| views/screens/tabs/components/drawer/panel              |     3 |    331 |       8 |    25 |    364 |
| views/screens/tabs/components/panel                     |     2 |    202 |      13 |    28 |    243 |
| views/screens/tabs/components/tile                      |     1 |    125 |      10 |    17 |    152 |
| views/screens/tabs/home_tab                             |     2 |    356 |       7 |    26 |    389 |
| views/screens/tabs/home_tab (Files)                     |     1 |    195 |       3 |    17 |    215 |
| views/screens/tabs/home_tab/components                  |     1 |    161 |       4 |     9 |    174 |
| views/screens/tabs/partner_tab                          |     2 |    250 |       8 |    16 |    274 |
| views/screens/tabs/partner_tab (Files)                  |     1 |     86 |       3 |     7 |     96 |
| views/screens/tabs/partner_tab/components               |     1 |    164 |       5 |     9 |    178 |
| views/screens/tutorial                                  |     1 |    156 |       5 |     8 |    169 |

上記はVSCodeCounterで数えたものになります。.gファイル(自動生成ファイル)を引いたステップ数は全体で16,593、コードのみで14,591です。

## ⚪︎ 本ポートフォリオにおけるアプリ起動方法

- 前提条件:git clone等でローカル環境に落として来ていること
- 動作OS:Android
- エディタ:vsCode

① android emulatorを用意してください。下記参照。
- [https://qiita.com/Kento210/items/2c9a967b1b9451b5cbcd](https://qiita.com/Kento210/items/2c9a967b1b9451b5cbcd)

② firebase emulatorを起動する
<br>ターミナルで下記のコマンドを実行してfirebase emulatorを起動する
- `firebase emulators:start`

③ アプリを起動する
<br>ターミナルでプロジェクトのルートディレクトリ(ur_habitsフォルダ配下)にいることを確認して下記のコマンドを実行する(あくまでも一例なのでvsCodeでGUI操作していただいても問題ないです。)
- `flutter run`

ポートフォリオではfirebase emulatorで動作しているため、新規でユーザー登録はできません。
<br>そのため、パートナーに関する操作は、デフォルトで登録されているユーザーをお使いください。
| Email         | Password |
| ------------- | -------- |
| a@ur-habi.com | aaaaaa   |
| b@ur-habi.com | bbbbb    |



## ⚪︎ 今後の展望

今後はよりユーザーが使いやすいような機能を追加していきたいと考えています。(記録するときの追加項目等)
<br>DB関してfirebaseやローカルDBに依存してしまっている部分があるため、リファクタリングやライブラリの導入を視野に入れて、より管理しやすい拡張性のあるアプリにしていきたいです。