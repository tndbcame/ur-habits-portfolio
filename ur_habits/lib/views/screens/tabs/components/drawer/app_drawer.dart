import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';

import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/screens/tabs/components/drawer/panel/partner_panel.dart';
import 'package:ur_habits/views/screens/tabs/components/drawer/panel/request_partner_panel.dart';
import 'package:ur_habits/views/screens/tabs/components/panel/login_panel.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/screens/tabs/components/panel/partner_request_panel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.firebaseViewModel,
  });

  final FirebaseViewModel firebaseViewModel;

  /// ユーザー情報を表示するセクションを構築
  Widget _buildUserInfoSection(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: kLightGray,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildUserDisplayName(context)),
          _buildUserActionButtons(context, snapshot),
        ],
      ),
    );
  }

  /// ユーザーの表示名を表示
  Widget _buildUserDisplayName(
    BuildContext context,
  ) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              height: 50,
              width: 10,
              child: Icon(
                HugeIcons.strokeRoundedUser,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: Center(
                child: StreamBuilder(
                  stream: firebaseViewModel.getUsersSnapshot(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      for (var doc in snapshot.data!.docs) {
                        if (doc.id == firebaseViewModel.getUid()) {
                          return Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  doc.data()['username'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: kDarkGray,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ユーザーのログアウトと設定ボタンを構築
  Widget _buildUserActionButtons(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    return SizedBox(
      width: snapshot.hasData ? 90 : 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (snapshot.hasData) _buildLogoutButton(context),
          _buildSettingsButton(context),
          if (snapshot.hasData)
            const SizedBox(
              width: 10,
            )
        ],
      ),
    );
  }

  /// ログアウトボタンを構築
  Widget _buildLogoutButton(
    BuildContext context,
  ) {
    return Container(
      height: 50,
      width: 40,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () async {
          final result = await DialogHelper.showSelectDialog(
            context,
            TextContents.confirmLogout.text,
            TextContents.ok.text,
            Theme.of(context).primaryColor,
          );
          if (result != null && result) {
            firebaseViewModel.logout();
          }
        },
        icon: Icon(
          HugeIcons.strokeRoundedLogoutCircle01,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  /// 設定ボタンを構築
  Widget _buildSettingsButton(BuildContext context) {
    return Container(
      height: 50,
      width: 40,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () async {
          await context.push(RouterEnums.setting.paths, extra: SettingsData());
        },
        icon: Icon(
          HugeIcons.strokeRoundedSettings01,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildPartnerRequestButton() {
    return StreamBuilder(
      stream: firebaseViewModel.getPartnerSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }

        return PartnerRequestPanel(
          firebaseViewModel: firebaseViewModel,
          backgroundColor: kLightGray5,
          exsitsPartner: true,
          isLimitPartner: snapshot.data!.docs.length >= limitPartner,
        );
      },
    );
  }

  /// ログイン状態のビューを構築
  Widget _buildLoggedInView(
    BuildContext context,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                PartnerPanel(
                  firebaseViewModel: firebaseViewModel,
                ),
                RequestPartnerPanel(
                  firebaseViewModel: firebaseViewModel,
                ),
                _buildPartnerRequestButton(),
              ],
            ),
          ),
          _buildUserIdAndEmail(context),
        ],
      ),
    );
  }

  /// ユーザーIDとメールアドレスを表示
  Widget _buildUserIdAndEmail(
    BuildContext context,
  ) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildUserInfo(
              context,
              label: TextContents.yourId.text,
              value: firebaseViewModel.getUid(),
              onTapIcon: () {
                Share.share(
                  firebaseViewModel.getUid(),
                );
              },
              onTapText: () async {
                await Clipboard.setData(
                  ClipboardData(text: firebaseViewModel.getUid()),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildUserInfo(
              context,
              label: TextContents.yourEmail.text,
              value: UITrimmer.shortenEmail(firebaseViewModel.getEmail()),
              onTapText: () async {
                await Clipboard.setData(
                  ClipboardData(text: firebaseViewModel.getEmail()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ユーザー情報の行を構築
  Widget _buildUserInfo(
    BuildContext context, {
    required String label,
    required String value,
    VoidCallback? onTapIcon,
    required VoidCallback onTapText,
  }) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: kDarkGray,
                ),
              ),
              if (onTapIcon != null)
                ColorChangingTextButton(
                  normalColor: Theme.of(context).primaryColor,
                  pressedColor: Theme.of(context).primaryColor.withAlpha(150),
                  isBoldText: false,
                  onTap: onTapIcon,
                  leftIcon: HugeIcons.strokeRoundedShare03,
                  textSize: 14,
                ),
            ],
          ),
          ColorChangingTextButton(
            normalColor: Theme.of(context).primaryColor,
            pressedColor: Theme.of(context).primaryColor.withAlpha(150),
            mainAxisAlignment: MainAxisAlignment.start,
            isBoldText: false,
            onTap: onTapText,
            labelText: value,
            textSize: 14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: kTextBaseColor,
        child: StreamBuilder(
          stream: firebaseViewModel.getSteamUser(),
          builder: (context, snapshot) {
            return Column(
              children: [
                _buildUserInfoSection(context, snapshot),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const CustomIndicator(),
                if (snapshot.hasData) _buildLoggedInView(context),
                if (!snapshot.hasData)
                  const LoginPanel(
                    backgroundColor: kLightGray5,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
