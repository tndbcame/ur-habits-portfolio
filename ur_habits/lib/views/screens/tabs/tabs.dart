import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/utils/ui/ui_helper.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/utils/helper/ads/ad_manager.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/screens/tabs/components/drawer/app_drawer.dart';
import 'package:ur_habits/view_models/providers/firebase_habits_provider.dart';
import 'package:ur_habits/view_models/providers/isar_habits_provider.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/screens/habit_detail/habit_details.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/screens/tabs/home_tab/home_tab.dart';
import 'package:ur_habits/views/screens/tabs/partner_tab/partner_tab.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RouteManager _routeManager = RouteManager();
  // final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();
  late AdManager _adManager;
  bool _isLoading = false;
  int _selectPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _adManager = AdManager();
    _adManager.loadBannerAd(AdSize.fullBanner);
    _adManager.loadInterstitialAd();
  }

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, _routeManager, [
      DiscriptionTitle(title: TextContents.home.text),
      DiscriptionText(text: TextContents.manageHabitInfo.text),
      DiscriptionTitle(title: TextContents.partner.text),
      DiscriptionText(text: TextContents.viewPartnerHabitInfo.text),
      const SizedBox(height: 20),
      DiscriptionText(text: TextContents.tutorialInfo.text),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _adManager.dispose();
  }

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _addItem() async {
    final publicHabitsSize =
        ref.read(firebaseHabitsProvider.notifier).countHabits();
    final newItem = await _routeManager.push<HabitView>(
      context,
      HabitDetailsScreen(
        isUpdate: false,
        publicHabitsSize: publicHabitsSize,
      ),
    );
    if (newItem == null) return;
    if (newItem.habitType == 1) {
      setState(() {
        ref.read(isarHabitsProvider.notifier).addHabit(newItem);
      });
    } else {
      _setIsLoading(true);
      try {
        await ref
            .read(firebaseHabitsProvider.notifier)
            .addHabit(newItem, false);
        await ref.read(firebaseHabitsProvider.notifier).fetchHabits();
      } finally {
        _setIsLoading(false);
      }
    }
    _adManager.showInterstitialAd();
  }

  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  Future<void> _showTutorial(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('isInitialLaunch') != true) {
      await pref.setBool('isInitialLaunch', true);
      if (!context.mounted) return;
      await _routeManager.showTutorial(context);
    }
  }

  /// BottomNavigationBar（ナビゲーションバー）
  Widget _buildBottomNavigationBar(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kTextBaseColor,
          ),
        ),
      ),
      child: NavigationBar(
        indicatorColor: kThirdBaseColor,
        backgroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Theme.of(context).primaryColor,
        onDestinationSelected: selectPage,
        selectedIndex: _selectPageIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              HugeIcons.strokeRoundedHome03,
              color: kTextBaseColor,
            ),
            label: TextContents.home.text,
          ),
          NavigationDestination(
            icon: const Icon(
              HugeIcons.strokeRoundedUserMultiple,
              color: kTextBaseColor,
            ),
            label: TextContents.partner.text,
          ),
        ],
      ),
    );
  }

  /// ホームタブ
  Widget _buildHomeTab(Future<bool>? usePublicHabits, double height) {
    if (usePublicHabits != null) {
      return FutureBuilder(
        future: usePublicHabits,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeTab(
              usePublicHabits: snapshot.data,
              routeManager: _routeManager,
            );
          }
          return SizedBox(
            height: height,
            child: const Center(
              child: CustomIndicator(
                color: kTextBaseColor,
              ),
            ),
          );
        },
      );
    }
    return HomeTab(
      routeManager: _routeManager,
    );
  }

  Widget _buildTabContent(Widget child, double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          child,
          SizedBox(
            width: _adManager.bannerAdWidth,
            height: _adManager.bannerAdHeight,
          )
        ],
      ),
    );
  }

  /// Body（メインコンテンツ）
  Widget _buildBody() {
    // return StreamBuilder(
    //   stream: _firebaseViewModel.getSteamUser(),
    //   builder: (context, snapshot) {
    //     final screenWidth = MediaQuery.of(context).size.width;
    //     final screenHeight = MediaQuery.of(context).size.height;
    //     final statusBarHeight = MediaQuery.of(context).padding.top;
    //     final availableHeight =
    //         UIHelper.calcScreenSize(screenHeight, statusBarHeight);
    //     if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
    //       return SizedBox(
    //         height: availableHeight * 0.85,
    //         child: const Center(
    //           child: CustomIndicator(
    //             color: kTextBaseColor,
    //           ),
    //         ),
    //       );
    //     }

    //     Future<bool>? usePublicHabits;
    //     if (snapshot.hasData) {
    //       usePublicHabits =
    //           ref.read(firebaseHabitsProvider.notifier).fetchHabits();
    //     }

    //     if (_selectPageIndex == 0) {
    //       return _buildTabContent(
    //           _buildHomeTab(usePublicHabits, availableHeight * 0.85),
    //           screenWidth);
    //     } else {
    //       return _buildTabContent(
    //           PartnerTab(
    //             routeManager: _routeManager,
    //             firebaseViewModel: _firebaseViewModel,
    //           ),
    //           screenWidth);
    //     }
    //   },
    // );

    //仮の処理作成
    final screenWidth = MediaQuery.of(context).size.width;
    if (_selectPageIndex == 0) {
      return _buildTabContent(
          HomeTab(
            routeManager: _routeManager,
          ),
          screenWidth);
    } else {
      return const Text('パートナータブは見れません');
    }
  }

  /// 追加ボタン
  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedAdd01,
        isBoldText: true,
        normalColor: kTextBaseColor,
        pressedColor: kTextBaseColorBlack,
        onTap: _addItem,
      ),
    );
  }

  ///メニューボタン（Drawerを開く)
  Widget _buildMenuButton() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ColorChangingTextButton(
        isBoldText: false,
        normalColor: kTextBaseColor,
        pressedColor: kTextBaseColorBlack,
        leftIcon: HugeIcons.strokeRoundedMenu01,
        onTap: () {
          _scaffoldKey.currentState?.openDrawer(); // Drawerを開く
        },
      ),
    );
  }

  /// ドロワー
  // Widget _buildDrawer() {
  //   return AppDrawer(
  //     firebaseViewModel: _firebaseViewModel,
  //     routeManager: _routeManager,
  //   );
  // }

  /// AppBar（アプリバー）
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        _selectPageIndex == 0
            ? TextContents.myHabitTab.text
            : TextContents.partnerHabitTab.text,
        style: const TextStyle(
          color: kTextBaseColor,
        ),
      ),
      centerTitle: true,
      leading: _buildMenuButton(),
      actions: _selectPageIndex == 0
          ? [HelpButton(onHelpTap: _showDescriptionDialog), _buildAddButton()]
          : [HelpButton(onHelpTap: _showDescriptionDialog, padding: 12)],
    );
  }

  @override
  Widget build(BuildContext context) {
    //チュートリアルの表示
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _showTutorial(context);
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kThirdBaseColor,
      appBar: _buildAppBar(context),
      //drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      bottomSheet: SizedBox(
        width: _adManager.bannerAdWidth,
        height: _adManager.bannerAdHeight,
        child: _adManager.getBannerAdWidget(),
      ),
    );
  }
}
