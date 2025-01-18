import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';

import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_manager.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/text_filed_dialog.dart';

class PartnerRequestPanel extends StatefulWidget {
  const PartnerRequestPanel({
    super.key,
    required this.firebaseViewModel,
    required this.backgroundColor,
    this.exsitsPartner = false,
    this.isLimitPartner = false,
  });

  final Color backgroundColor;
  final FirebaseViewModel firebaseViewModel;
  final bool exsitsPartner;
  final bool isLimitPartner;

  @override
  State<PartnerRequestPanel> createState() => _PartnerRequestPanelState();
}

class _PartnerRequestPanelState extends State<PartnerRequestPanel>
    with TickerProviderStateMixin {
  final OverlayManager _overlayManager = OverlayManager();

  /// ユーザーの存在状況に応じた処理
  void _handleUserExistence(
      BuildContext context, int existStatus, String partnerId) {
    if (existStatus == 0) {
      widget.firebaseViewModel
          .setPartnerRequests(widget.firebaseViewModel.getUid(), partnerId);
      if (!context.mounted) return;
      DialogHelper.showCautionDialog(context, TextContents.requestSent.text);
    } else if (existStatus == 1) {
      DialogHelper.showCautionDialog(
          context, TextContents.userNotRegistered.text);
    } else if (existStatus == 2) {
      DialogHelper.showCautionDialog(
          context, TextContents.partnerAlreadyLimits.text);
    } else {
      DialogHelper.showCautionDialog(
          context, TextContents.unexpectedError.text);
    }
  }

  /// 自分自身に送信していないか確認する
  bool _isSendingToSelf(String partnerId) {
    return widget.firebaseViewModel.getUid() == partnerId;
  }

  /// オーバーレイダイアログを表示
  void _showOverlayDialog(BuildContext context, String message) {
    _overlayManager.showOverlayDialog(context, this, message);
  }

  /// パートナーID入力ダイアログを表示する
  Future<void> _showPartnerIdInputDialog(BuildContext context) async {
    String? partnerId = await DialogHelper.showAnimationDialog<String>(
      context,
      TextFiledDialog(
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
          context, TextContents.cannotSendToSelf.text);
      return;
    }

    int existStatus = await widget.firebaseViewModel.checkUserExists(partnerId);
    existStatus = await widget.firebaseViewModel.checkPartnerExists(partnerId);
    if (!context.mounted) return;
    _handleUserExistence(context, existStatus, partnerId);
  }

  /// パートナー申請ボタンを構築
  Widget _buildRequestButton(BuildContext context) {
    return ColorChangingTextButton(
      normalColor: Theme.of(context).primaryColor,
      pressedColor: Theme.of(context).primaryColor.withAlpha(150),
      isBoldText: false,
      onTap: () => widget.isLimitPartner
          ? _showOverlayDialog(context, TextContents.yourPartnerIsLimit.text)
          : _showPartnerIdInputDialog(context),
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
      color: widget.backgroundColor,
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
    if (widget.exsitsPartner) {
      return _buildPartnerRequestButton(context);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildPanelContainer(context),
    );
  }
}
