import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/view_models/providers/theme_provider.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_button.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';
import 'package:ur_habits/views/screens/auth/re_names.dart';
import 'package:ur_habits/views/screens/setting/components/tile/change_password_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/change_username_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/login_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/logout_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/terms_of_service_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/unregister_tile.dart';
import 'package:ur_habits/views/screens/setting/components/tile/ur_habtis_tutorials_tile.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({
    super.key,
  });
  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final RouteManager _routeManager = RouteManager();
//  final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();
  bool isLoading = false;
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    final currentColorKey =
        ref.read(themeNotifierProvider.notifier).currentColorKey;
    selectedColor = currentColorKey;
  }

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, _routeManager, [
      DiscriptionTitle(title: TextContents.theme.text),
      DiscriptionText(text: TextContents.changeThemeColor.text),
      DiscriptionTitle(title: TextContents.privacyPolicy.text),
      DiscriptionText(text: TextContents.viewPrivacyPolicy.text),
      DiscriptionTitle(title: TextContents.termsOfService.text),
      DiscriptionText(text: TextContents.viewTermsOfService.text),
      DiscriptionTitle(title: TextContents.license.text),
      DiscriptionText(text: TextContents.viewLicenseInfo.text),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DiscriptionText(
          text: TextContents.loginOnlyItem.text,
          size: 16,
        ),
      ),
      DiscriptionTitle(title: TextContents.updateUsername.text),
      DiscriptionText(text: TextContents.changeAccountUsername.text),
      DiscriptionTitle(title: TextContents.updatePassword.text),
      DiscriptionText(text: TextContents.changeAccountPassword.text),
      DiscriptionTitle(title: TextContents.logout.text),
      DiscriptionText(text: TextContents.performLogout.text),
      DiscriptionTitle(title: TextContents.confirmWithdrawalAction.text),
      DiscriptionText(text: TextContents.unregister.text),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DiscriptionText(
          text: TextContents.nonLoginOnlyItem.text,
          size: 16,
        ),
      ),
      DiscriptionTitle(title: TextContents.login.text),
      DiscriptionText(text: TextContents.performLogin.text),
    ]);
  }

  void setThemeColor(String color) {
    ref.read(themeNotifierProvider.notifier).setTheme(colorKey: color);
  }

  ///選択された色を設定する
  void setSelectedColor(String color) {
    setState(() {
      selectedColor = color;
    });
  }

  /// ユーザー名変更時の処理を行う
  Future<void> _handleChangeUsername() async {
    // String currentName =
    //     await _firebaseViewModel.getUsername(_firebaseViewModel.getUid());

    // if (!mounted) return;
    // final newUsername = await _routeManager.push<String>(
    //   context,
    //   ReNameScreen(
    //     routeManager: _routeManager,
    //     name: currentName,
    //   ),
    // );

    // if (newUsername == null) return;

    // setState(() {
    //   isLoading = true;
    // });

    // try {
    //   await _firebaseViewModel.updateMyname(
    //       _firebaseViewModel.getUid(), newUsername);
    //   final partnerInfos =
    //       await _firebaseViewModel.getPartnerInfo(_firebaseViewModel.getUid());

    //   if (partnerInfos.isNotEmpty) {
    //     await _firebaseViewModel.updatePartnername(
    //       _firebaseViewModel.getUid(),
    //       partnerInfos.entries.first.key,
    //       newUsername,
    //     );
    //   }
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  /// ログアウト処理を行う
  Future<void> _handleLogout() async {
    // final result = await DialogHelper.showSelectDialog(
    //   context,
    //   _routeManager,
    //   TextContents.confirmLogout.text,
    //   TextContents.ok.text,
    //   Theme.of(context).primaryColor,
    // );

    // if (result != null && result) {
    //   _firebaseViewModel.logout();
    // }
  }

  Widget _buildColorButton(String color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: ColorChangingButton(
        normalColor: baseColorMap[color]!,
        pressedColor: baseColorMap[color]!.withAlpha(150),
        onTap: () {
          setSelectedColor(color);
          setThemeColor(color);
        },
        isSelected: selectedColor == color,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 110, //leadingWidthを設定する
      leading: Padding(
        padding: EdgeInsets.only(left: isLoading ? 8 : 0),
        child: ColorChangingTextButton(
          leftIcon: isLoading ? null : HugeIcons.strokeRoundedArrowLeft01,
          labelText:
              isLoading ? TextContents.loading.text : TextContents.back.text,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
          onTap: () {
            if (isLoading) return;
            _routeManager.pop(context);
          },
        ),
      ),
      title: Text(
        TextContents.settings.text,
        style: const TextStyle(
          color: kTextThirdBaseColor,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: kLightGray3,
      actions: <Widget>[
        HelpButton(
          onHelpTap: _showDescriptionDialog,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
          padding: 12,
        )
      ],
    );
  }

  /// 「その他」セクションのタイトルを表示する
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(color: kTextThirdBaseColor),
            ),
          ),
        ],
      ),
    );
  }

  /// 設定関連のリスト項目をまとめた
  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          color: kLightGray3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeSettingTile(),
            TermsOfServiceTile(
              routeManager: _routeManager,
              title: TextContents.privacyPolicy.text,
              url: urlMap['privacyPolicy']!,
              iconData: HugeIcons.strokeRoundedFileSecurity,
            ),
            TermsOfServiceTile(
              routeManager: _routeManager,
              title: TextContents.termsOfService.text,
              url: urlMap['termsOfService']!,
              iconData: HugeIcons.strokeRoundedLicense,
            ),
            TermsOfServiceTile(
              routeManager: _routeManager,
              title: TextContents.license.text,
              url: urlMap['license']!,
              iconData: HugeIcons.strokeRoundedLicenseThirdParty,
            ),
            UrHabtisTutorialsTile(
              routeManager: _routeManager,
              isFinal: true,
            ),
          ],
        ),
      ),
    );
  }

  /// テーマ設定用のリストタイルを生成する
  Widget _buildThemeSettingTile() {
    return AuthListTile(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      title: Center(
        child: Text(
          TextContents.theme.text,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      isFirst: true,
      mainItem: [
        _buildColorButton('BLUE'),
        _buildColorButton('GREEN'),
        _buildColorButton('RED'),
        _buildColorButton('YELLOW'),
        _buildColorButton('PURPLE'),
      ],
    );
  }

  // /// アカウント関連のセクションをまとめた
  // Widget _buildAccountSection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: kLightGray3,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: StreamBuilder(
  //         stream: _firebaseViewModel.getSteamUser(),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             return _buildUserAccountOptions();
  //           }
  //           return LoginTile(routeManager: _routeManager);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // /// ユーザーのアカウント関連の操作をまとめた
  // Widget _buildUserAccountOptions() {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       ChangeUsernameTile(onUsernameChange: _handleChangeUsername),
  //       ChangePasswordTile(
  //           email: _firebaseViewModel.getEmail(), routeManager: _routeManager),
  //       LogoutTile(onLogout: _handleLogout),
  //       UnregisterTile(
  //           routeManager: _routeManager, firebaseViewModel: _firebaseViewModel)
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: _buildAppBar(),
      body: isLoading
          ? const Center(
              child: CustomIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildSectionTitle(TextContents.others.text),
                  _buildSettingsSection(),
                  _buildSectionTitle(TextContents.account.text),
                  //_buildAccountSection(),
                ],
              ),
            ),
    );
  }
}
