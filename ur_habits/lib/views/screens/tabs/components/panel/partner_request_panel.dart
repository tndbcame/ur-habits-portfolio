import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/text_filed_dialog.dart';

class PartnerRequestPanel extends StatelessWidget {
  const PartnerRequestPanel({
    super.key,
    required this.routeManager,
    required this.firebaseViewModel,
    required this.backgroundColor,
  });
  final RouteManager routeManager;
  final Color backgroundColor;
  final FirebaseViewModel firebaseViewModel;

  /// ユーザーの存在状況に応じた処理
  void _handleUserExistence(
      BuildContext context, int existStatus, String partnerId) {
    if (existStatus == 0) {
      firebaseViewModel.setPartnerRequests(
          firebaseViewModel.getUid(), partnerId);
      if (!context.mounted) return;
      DialogHelper.showCautionDialog(
          context, routeManager, TextContents.requestSent.text);
    } else if (existStatus == 1) {
      DialogHelper.showCautionDialog(
          context, routeManager, TextContents.userNotRegistered.text);
    } else if (existStatus == 2) {
      DialogHelper.showCautionDialog(
          context, routeManager, TextContents.partnerAlreadyExists.text);
    } else {
      DialogHelper.showCautionDialog(
          context, routeManager, TextContents.unexpectedError.text);
    }
  }

  /// 自分自身に送信していないか確認する
  bool _isSendingToSelf(String partnerId) {
    return firebaseViewModel.getUid() == partnerId;
  }

  /// パートナーID入力ダイアログを表示する
  Future<void> _showPartnerIdInputDialog(BuildContext context) async {
    String? partnerId = await routeManager.showAnimationDialog<String>(
      context,
      TextFiledDialog(
        routeManager: routeManager,
        titleText: TextContents.enterPartnerId.text,
        hintText: TextContents.partnerId.text,
      ),
      animaType: 2,
    );
    if (!context.mounted) return;
    if (partnerId == null || partnerId.isEmpty) {
      return;
    }
    if (_isSendingToSelf(partnerId)) {
      DialogHelper.showCautionDialog(
          context, routeManager, TextContents.cannotSendToSelf.text);
      return;
    }

    int existStatus = await firebaseViewModel.checkUserExists(partnerId);
    existStatus = await firebaseViewModel.checkPartnerExists(partnerId);
    if (!context.mounted) return;
    _handleUserExistence(context, existStatus, partnerId);
  }

  /// パートナー申請ボタンを構築
  Widget _buildRequestButton(BuildContext context) {
    return ColorChangingTextButton(
      normalColor: Theme.of(context).primaryColor,
      pressedColor: Theme.of(context).primaryColor.withAlpha(150),
      isBoldText: false,
      onTap: () => _showPartnerIdInputDialog(context),
      leftIcon: HugeIcons.strokeRoundedShare01,
      labelText: TextContents.requestPartner.text,
      textSize: 14,
    );
  }

  /// パートナー申請ボタンの配置
  Widget _buildPartnerRequestButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRequestButton(context),
        ],
      ),
    );
  }

  Widget _buildNoPartnerText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(TextContents.noPartner.text),
    );
  }

  /// コンテナの装飾を設定
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
    );
  }

  /// パネルのコンテナを構築
  Widget _buildPanelContainer(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNoPartnerText(),
          _buildPartnerRequestButton(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildPanelContainer(context),
    );
  }
}
