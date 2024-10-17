import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceTile extends StatelessWidget {
  const TermsOfServiceTile({
    super.key,
    required this.routeManager,
    required this.title,
    required this.url,
    required this.iconData,
    this.isFinal = false,
  });
  final RouteManager routeManager;
  final String title;
  final String url;
  final IconData iconData;
  final bool isFinal;

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: Icon(
        iconData,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      isFinal: isFinal,
      mainAxisAlignment: MainAxisAlignment.center,
      onTap: () async {
        final Uri flutterUrl = Uri.parse(url);
        try {
          await launchUrl(flutterUrl, mode: LaunchMode.externalApplication);
        } catch (e) {
          if (!context.mounted) return;
          DialogHelper.showCautionDialog(
              context, routeManager, TextContents.errorOccurred.text);
        }
      },
      mainItem: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
