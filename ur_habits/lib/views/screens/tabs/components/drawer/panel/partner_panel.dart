import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';

import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/screens/tabs/components/drawer/panel/app_drawer_panel.dart';
import 'package:ur_habits/views/screens/tabs/components/panel/partner_request_panel.dart';

class PartnerPanel extends StatelessWidget {
  const PartnerPanel({
    super.key,
    required this.firebaseViewModel,
  });

  final FirebaseViewModel firebaseViewModel;

  Widget _buildPanelWithPartner(AsyncSnapshot snapshot, BuildContext context) {
    return AppDrawerPanel(
      width: 300,
      title: TextContents.partner.text,
      partnerCount: snapshot.data!.docs.length,
      titleColor: kDarkGray,
      widgetList: [
        for (final doc in snapshot.data!.docs) ...{
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doc.data()['username'].toString(),
                  style: const TextStyle(fontSize: 14, color: kDarkGray),
                ),
                ColorChangingTextButton(
                  normalColor: kSecondBaseColor,
                  pressedColor: kSecondBaseColor.withAlpha(150),
                  leftIcon: HugeIcons.strokeRoundedCancelCircle,
                  onTap: () async {
                    final result = await DialogHelper.showSelectDialog(
                      context,
                      '${doc.data()['username'].toString()}さん\n${TextContents.confirmPartnerRemoval.text}',
                      TextContents.ok.text,
                      kSecondBaseColor,
                    );
                    if (result != null && result) {
                      firebaseViewModel.deletePartner(
                        firebaseViewModel.getUid(),
                        doc.id,
                      );
                    }
                  },
                  isBoldText: false,
                )
              ],
            ),
          ),
        }
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseViewModel.getPartnerSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return PartnerRequestPanel(
            firebaseViewModel: firebaseViewModel,
            backgroundColor: kLightGray5,
          );
        }

        return _buildPanelWithPartner(snapshot, context);
      },
    );
  }
}
