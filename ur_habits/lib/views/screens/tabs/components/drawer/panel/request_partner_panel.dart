import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/screens/tabs/components/drawer/panel/app_drawer_panel.dart';

class RequestPartnerPanel extends StatelessWidget {
  const RequestPartnerPanel({
    super.key,
    required this.firebaseViewModel,
  });

  final FirebaseViewModel firebaseViewModel;

  /// パートナー依頼のストリームを監視し、パネルを構築
  Widget _buildPartnerRequestStreamPanel(
      BuildContext context, AsyncSnapshot snapshot) {
    final docs = snapshot.data?.docs;

    return AppDrawerPanel(
      width: 300,
      title: TextContents.partnerRequest.text,
      titleColor: kDarkGray,
      widgetList: [
        if (docs != null && docs.isNotEmpty)
          for (var doc in docs) _buildRequestRow(context, doc),
        if (docs == null || docs.isEmpty) _buildNoRequestsMessage(),
      ],
    );
  }

  /// パートナー依頼の各行を構築
  Widget _buildRequestRow(
      BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            doc['username'],
            style: const TextStyle(fontSize: 14, color: kDarkGray),
          ),
          Row(
            children: [
              _buildRequestActionButton(
                icon: HugeIcons.strokeRoundedDoNotTouch02,
                color: kSecondBaseColor,
                onPressed: () => _handleDenyRequest(context, doc),
              ),
              _buildApprovalStreamButton(context, doc),
            ],
          ),
        ],
      ),
    );
  }

  /// 拒否ボタンのアクションを処理
  Future<void> _handleDenyRequest(BuildContext context,
      QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    bool? result = await DialogHelper.showSelectDialog(
      context,
      TextContents.confirmRejection.text,
      TextContents.ok.text,
      kSecondBaseColor,
    );
    if (result != null && result) {
      firebaseViewModel.handleRequestAction(
        doc,
        true, // isDeny
        firebaseViewModel.getUid(),
      );
    }
  }

  /// 承認ボタンのストリームビルダー
  Widget _buildApprovalStreamButton(
      BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return StreamBuilder(
      stream: firebaseViewModel.getUsersSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String myName = snapshot.data!.docs
              .where((doc) => doc.id == firebaseViewModel.getUid())
              .first
              .data()['username']
              .toString();
          return _buildRequestActionButton(
            icon: HugeIcons.strokeRoundedThumbsUp,
            color: Theme.of(context).primaryColor,
            onPressed: () => _handleApproveRequest(context, doc, myName),
          );
        }
        return const SizedBox();
      },
    );
  }

  /// 承認ボタンのアクションを処理
  Future<void> _handleApproveRequest(
    BuildContext context,
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    String myName,
  ) async {
    bool? result = await DialogHelper.showSelectDialog(
      context,
      TextContents.confirmApproval.text,
      TextContents.ok.text,
      Theme.of(context).primaryColor,
    );
    if (result != null && result) {
      int partnerExistStatus =
          await firebaseViewModel.checkPartnerExists(doc.id);
      if (!context.mounted) return;
      _processPartnerApprovalStatus(context, partnerExistStatus, doc, myName);
    }
  }

  /// パートナー承認状況を処理
  void _processPartnerApprovalStatus(
    BuildContext context,
    int status,
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    String myName,
  ) {
    if (status == 0) {
      firebaseViewModel.handleRequestAction(
        doc,
        false, // isDeny
        firebaseViewModel.getUid(),
        name: myName,
      );
    } else if (status == 2) {
      DialogHelper.showCautionDialog(
        context,
        TextContents.cannotApprovePartner.text,
      );
    } else {
      DialogHelper.showCautionDialog(
        context,
        TextContents.unexpectedError.text,
      );
    }
  }

  /// 拒否・承認ボタンの共通ウィジェットを構築
  Widget _buildRequestActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 50,
      width: 40,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
      ),
    );
  }

  /// パートナー依頼がない場合のメッセージを表示
  Widget _buildNoRequestsMessage() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TextContents.noRequests.text,
              style: const TextStyle(color: kDarkGray),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseViewModel.getRequestsSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomIndicator();
        }
        return _buildPartnerRequestStreamPanel(context, snapshot);
      },
    );
  }
}
