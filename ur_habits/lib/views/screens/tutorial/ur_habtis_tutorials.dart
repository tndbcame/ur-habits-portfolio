import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';

class UrHabitsTutorialScreen extends StatelessWidget {
  const UrHabitsTutorialScreen({
    super.key,
  });

  // 画像を生成する
  Widget _buildImage(BuildContext context, String path) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Image.asset(path),
    );
  }

  // タイトルテキストを生成する
  Widget _buildTitleText(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: kTextBaseColor,
        ),
      ),
    );
  }

  // 説明テキストを生成する
  Widget _buildDescriptionText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(color: kTextBaseColor),
      ),
    );
  }

  // ページモデルを生成する
  PageModel _buildPageModel({
    required BuildContext context,
    required String imagePath,
    required String titleText,
    required String descriptionText,
    bool doAnimateChild = true,
  }) {
    return PageModel.withChild(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildImage(context, imagePath),
            _buildTitleText(titleText),
            _buildDescriptionText(descriptionText),
          ],
        ),
      ),
      doAnimateChild: doAnimateChild,
    );
  }

  // チュートリアルのページを構築する
  List<PageModel> _buildPages(BuildContext context) {
    return [
      _buildPageModel(
        context: context,
        imagePath: assetsMap['homeTutorial1']!,
        titleText: TextContents.initialScreen.text,
        descriptionText: TextContents.trackAllHabitsScreenDescription.text,
        doAnimateChild: false,
      ),
      _buildPageModel(
        context: context,
        imagePath: assetsMap['recordTutorial1']!,
        titleText: TextContents.calendarRecordScreenDescription.text,
        descriptionText: TextContents.trackHabitsByMonthDescription.text,
      ),
      _buildPageModel(
        context: context,
        imagePath: assetsMap['recordTutorial2']!,
        titleText: TextContents.goalAchievementScreenDescription.text,
        descriptionText: TextContents.habitGoalAchievementScreen.text,
      ),
      _buildPageModel(
        context: context,
        imagePath: assetsMap['homeTutorial2']!,
        titleText: TextContents.menuBarDescription.text,
        descriptionText: TextContents.openMenuAndRegisterPartner.text,
      ),
      _buildPageModel(
        context: context,
        imagePath: assetsMap['loginTutorial1']!,
        titleText: TextContents.login.text,
        descriptionText: TextContents.loginPrompt.text,
      ),
      _buildPageModel(
        context: context,
        imagePath: assetsMap['loginTutorial2']!,
        titleText: TextContents.addPartnerInstructions.text,
        descriptionText: TextContents.registerPartnerInstructions.text,
      ),
      PageModel.withChild(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              _buildImage(context, assetsMap['loginTutorial3']!),
              _buildTitleText(TextContents.partnerApprovalInstructions.text),
              _buildDescriptionText(TextContents.partnerApprovalProcess.text),
            ],
          ),
        ),
        doAnimateChild: true,
      ),
      PageModel.withChild(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              _buildImage(context, assetsMap['loginTutorial4']!),
              _buildTitleText(TextContents.partnerRegisteredConfirmation.text),
              _buildDescriptionText(
                  TextContents.shareHabitsWithPartnerInstructions.text),
            ],
          ),
        ),
        doAnimateChild: true,
      ),
      PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Text(
            TextContents.recordYourHabitPrompt.text,
            style: const TextStyle(
              color: kTextBaseColor,
              fontSize: 32,
            ),
          ),
        ),
        color: kSecondBaseColor,
        doAnimateChild: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: _buildPages(context),
        showBullets: true,
        skipCallback: () {
          context.pop();
        },
        finishCallback: () {
          context.pop();
        },
      ),
    );
  }
}
