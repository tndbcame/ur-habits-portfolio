import 'package:community_material_icon/community_material_icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';

const int limitPartner = 3;
const int limitPublicHabits = 3;

enum TenkeyNumber {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  zero,
  zeroDouble,
  decimal,
  clear,
  delete,
}

final _now = DateTime.now();
final _nowDate = DateTime(_now.year, _now.month, _now.day);

final weekdays = ['月', '火', '水', '木', '金', '土', '日'];

final Map<String, String> urlMap = {
  'privacyPolicy': 'https://ur-habits.web.app/privacy-policy.html',
  'termsOfService': 'https://ur-habits.web.app/terms-of-service.html',
  'license': 'https://ur-habits.web.app/license.html',
};

final Map<String, String> assetsMap = {
  'urHabitsTitle': 'assets/icons/ur_habits_title.png',
  'homeTutorial1': 'assets/tutorial_images/home1.png',
  'recordTutorial1': 'assets/tutorial_images/record1.png',
  'recordTutorial2': 'assets/tutorial_images/record2.png',
  'homeTutorial2': 'assets/tutorial_images/home2.png',
  'loginTutorial1': 'assets/tutorial_images/login1.png',
  'loginTutorial2': 'assets/tutorial_images/login2.png',
  'loginTutorial3': 'assets/tutorial_images/login3.png',
  'loginTutorial4': 'assets/tutorial_images/login4.png',
};

final incDecTypes = {
  1: "現在値より大きい",
  2: "現在値より小さい",
};

final accumulationTypes = {
  1: "正の累積",
  2: "負の累積",
  3: "累積しない",
};

final dataTypes = [
  const DataType(1, "整数", "回"),
  const DataType(2, "小数", "kg"),
  const DataType(3, "時間(分)", "h:m"),
  const DataType(4, "時間(秒)", "h:m:s"),
  const DataType(6, "チェックボックス", "なし"),
  const DataType(7, "５段階評価", "なし"),
  const DataType(8, "カウンター", "回"),
];

final defaultHabitGoals = {
  DefalutGoals.weight: HabitGoalView(
    title: "体重5kg減らす",
    incDecTyep: 2,
    currentValues: HabitValues(str: '80'),
    targetValues: HabitValues(str: '75'),
    inputedDate: _nowDate,
    deadline: null,
    memo: "",
  ),
  DefalutGoals.absExercise: HabitGoalView(
    title: "腹筋を割る",
    incDecTyep: 1,
    currentValues: HabitValues(str: '0'),
    targetValues: HabitValues(str: '3000'),
    inputedDate: _nowDate,
    deadline: null,
    memo: "毎日最低一回はやる！",
  )
};

final defaultHabits = [
  HabitView(
    id: 0,
    habitType: 1,
    title: "体重",
    iconId: 43,
    dataType: dataTypes[1],
    unit: 'kg',
    accumulationType: 3,
    isGoal: true,
    goal: defaultHabitGoals[DefalutGoals.weight]!,
    records: <DateTime, HabitValues>{
      defaultHabitGoals[DefalutGoals.weight]!.inputedDate:
          defaultHabitGoals[DefalutGoals.weight]!.currentValues
    },
    sort: '0',
  ),
  HabitView(
    id: 0,
    habitType: 1,
    title: "腹筋",
    iconId: 48,
    dataType: dataTypes[0],
    unit: '回',
    accumulationType: 1,
    isGoal: true,
    goal: defaultHabitGoals[DefalutGoals.absExercise]!,
    records: <DateTime, HabitValues>{
      defaultHabitGoals[DefalutGoals.absExercise]!.inputedDate:
          defaultHabitGoals[DefalutGoals.absExercise]!.currentValues
    },
    sort: '1',
  )
];

final habitIcons = {
  1: HugeIcons.strokeRoundedWorkoutRun,
  2: HugeIcons.strokeRoundedWorkoutGymnastics,
  3: HugeIcons.strokeRoundedWorkoutStretching,
  4: HugeIcons.strokeRoundedWorkoutSquats,
  5: HugeIcons.strokeRoundedWorkoutSport,
  6: HugeIcons.strokeRoundedSwimming,
  7: HugeIcons.strokeRoundedYoga01,
  8: HugeIcons.strokeRoundedYoga02,
  9: HugeIcons.strokeRoundedSkippingRope,
  10: HugeIcons.strokeRoundedRunningShoes,
  11: HugeIcons.strokeRoundedBaseball,
  12: HugeIcons.strokeRoundedBaseballBat,
  13: HugeIcons.strokeRoundedFootball,
  14: HugeIcons.strokeRoundedBasketball01,
  15: HugeIcons.strokeRoundedBasketball02,
  16: HugeIcons.strokeRoundedAmericanFootball,
  17: HugeIcons.strokeRoundedVolleyball,
  18: HugeIcons.strokeRoundedGolfBall,
  19: HugeIcons.strokeRoundedYogaBall,
  20: HugeIcons.strokeRoundedTennisBall,
  21: HugeIcons.strokeRoundedBowlingPins,
  22: HugeIcons.strokeRoundedBoxingGlove01,
  23: HugeIcons.strokeRoundedDumbbell01,
  24: HugeIcons.strokeRoundedDumbbell02,
  25: HugeIcons.strokeRoundedBicycle01,
  26: HugeIcons.strokeRoundedBicycle01,
  27: HugeIcons.strokeRoundedDroplet,
  28: HugeIcons.strokeRoundedWaterEnergy,
  29: HugeIcons.strokeRoundedBloodBag,
  30: HugeIcons.strokeRoundedBloodBottle,
  31: HugeIcons.strokeRoundedBloodPressure,
  32: HugeIcons.strokeRoundedBrain02,
  33: HugeIcons.strokeRoundedDigestion,
  34: HugeIcons.strokeRoundedKidneys,
  35: HugeIcons.strokeRoundedDentalTooth,
  36: HugeIcons.strokeRoundedMedicineBottle01,
  37: HugeIcons.strokeRoundedMedicineBottle02,
  38: HugeIcons.strokeRoundedHospital02,
  39: HugeIcons.strokeRoundedThermometer,
  40: HugeIcons.strokeRoundedMedicine02,
  41: HugeIcons.strokeRoundedMedicine01,
  42: HugeIcons.strokeRoundedGravity,
  43: HugeIcons.strokeRoundedWeightScale,
  44: HugeIcons.strokeRoundedWeightScale01,
  45: HugeIcons.strokeRoundedBodyWeight,
  46: HugeIcons.strokeRoundedBodyPartLeg,
  47: HugeIcons.strokeRoundedBodyPartMuscle,
  48: HugeIcons.strokeRoundedBodyPartSixPack,
  49: HugeIcons.strokeRoundedTimer01,
  50: HugeIcons.strokeRoundedTimer02,
  51: HugeIcons.strokeRoundedHourglass,
  52: HugeIcons.strokeRoundedTapeMeasure,
  53: HugeIcons.strokeRoundedRuler,
  54: HugeIcons.strokeRoundedApple,
  55: HugeIcons.strokeRoundedApple01,
  56: HugeIcons.strokeRoundedBanana,
  57: HugeIcons.strokeRoundedApplePie,
  58: HugeIcons.strokeRoundedBirthdayCake,
  59: HugeIcons.strokeRoundedCheeseCake02,
  60: HugeIcons.strokeRoundedBread03,
  61: HugeIcons.strokeRoundedBread04,
  62: HugeIcons.strokeRoundedChickenThighs,
  63: HugeIcons.strokeRoundedDimSum01,
  64: HugeIcons.strokeRoundedFrenchFries01,
  65: HugeIcons.strokeRoundedBubbleTea02,
  66: HugeIcons.strokeRoundedCoffee02,
  67: HugeIcons.strokeRoundedCoffee01,
  68: HugeIcons.strokeRoundedDrink,
  69: HugeIcons.strokeRoundedIceCream01,
  70: HugeIcons.strokeRoundedIceCream02,
  71: HugeIcons.strokeRoundedIceCream03,
  72: HugeIcons.strokeRoundedIceCream04,
  73: HugeIcons.strokeRoundedChefHat,
  74: HugeIcons.strokeRoundedBadminton,
  75: HugeIcons.strokeRoundedRestaurant01,
  76: HugeIcons.strokeRoundedRestaurant02,
  77: HugeIcons.strokeRoundedDish02,
  78: HugeIcons.strokeRoundedKitchenUtensils,
  79: HugeIcons.strokeRoundedKnife02,
  80: HugeIcons.strokeRoundedDish01,
  81: HugeIcons.strokeRoundedPan03,
  82: HugeIcons.strokeRoundedPot02,
  83: HugeIcons.strokeRoundedPaintBucket,
  84: HugeIcons.strokeRoundedBookBookmark02,
  85: HugeIcons.strokeRoundedBook03,
  86: HugeIcons.strokeRoundedAudioBook03,
  87: HugeIcons.strokeRoundedBookEdit,
  88: HugeIcons.strokeRoundedBookOpen01,
  89: HugeIcons.strokeRoundedTabletPen,
  90: HugeIcons.strokeRoundedKnowledge01,
  91: HugeIcons.strokeRoundedKnowledge02,
  92: HugeIcons.strokeRoundedCalendar03,
  93: HugeIcons.strokeRoundedPenTool03,
  94: HugeIcons.strokeRoundedPencil,
  95: HugeIcons.strokeRoundedGraduateMale,
  96: HugeIcons.strokeRoundedGraduateFemale,
  97: HugeIcons.strokeRoundedGraduationScroll,
  98: HugeIcons.strokeRoundedLaptop,
  99: HugeIcons.strokeRoundedLaptopCheck,
  100: HugeIcons.strokeRoundedLaptopPerformance,
  101: HugeIcons.strokeRoundedLaptopVideo,
  102: HugeIcons.strokeRoundedLaptopPhoneSync,
  103: HugeIcons.strokeRoundedLaptopProgramming,
  104: HugeIcons.strokeRoundedWebProgramming,
  105: HugeIcons.strokeRoundedProgrammingFlag,
  106: HugeIcons.strokeRoundedMobileProgramming01,
  107: HugeIcons.strokeRoundedMobileProgramming02,
  108: HugeIcons.strokeRoundedComputerProgramming01,
  109: HugeIcons.strokeRoundedComputerProgramming02,
  110: HugeIcons.strokeRoundedSql,
  111: HugeIcons.strokeRoundedCProgramming,
  112: HugeIcons.strokeRoundedJava,
  113: HugeIcons.strokeRoundedJar,
  114: HugeIcons.strokeRoundedJavaScript,
  115: HugeIcons.strokeRoundedGoogle,
  116: HugeIcons.strokeRoundedAndroid,
  117: HugeIcons.strokeRoundedMail01,
  118: HugeIcons.strokeRoundedFolder01,
  119: HugeIcons.strokeRoundedFile01,
  121: HugeIcons.strokeRoundedTask01,
  122: HugeIcons.strokeRoundedComet01,
  123: HugeIcons.strokeRoundedAiBrain03,
  124: HugeIcons.strokeRoundedPrinter,
  125: HugeIcons.strokeRoundedAids,
  126: HugeIcons.strokeRoundedSchoolTie,
  127: HugeIcons.strokeRoundedChartIncrease,
  128: HugeIcons.strokeRoundedAlarmClock,
  129: HugeIcons.strokeRoundedSleeping,
  130: HugeIcons.strokeRoundedMoon,
  131: HugeIcons.strokeRoundedMoon02,
  132: HugeIcons.strokeRoundedSleeping,
  133: HugeIcons.strokeRoundedMoonset,
  134: HugeIcons.strokeRoundedFallingStar,
  135: HugeIcons.strokeRoundedSun01,
  136: HugeIcons.strokeRoundedSun03,
  137: HugeIcons.strokeRoundedUv02,
  138: HugeIcons.strokeRoundedSunrise,
  139: HugeIcons.strokeRoundedSunset,
  140: HugeIcons.strokeRoundedSolarSystem,
  141: HugeIcons.strokeRoundedSolarSystem,
  142: HugeIcons.strokeRoundedClean,
  143: HugeIcons.strokeRoundedCleaningBucket,
  144: HugeIcons.strokeRoundedToilet01,
  145: HugeIcons.strokeRoundedDishWasher,
  146: HugeIcons.strokeRoundedHairDryer,
  147: HugeIcons.strokeRoundedDelete03,
  148: HugeIcons.strokeRoundedDeletePutBack,
  149: HugeIcons.strokeRoundedYoutube,
  150: HugeIcons.strokeRoundedTwitter,
  151: HugeIcons.strokeRoundedInstagram,
  152: HugeIcons.strokeRoundedGun,
  153: HugeIcons.strokeRoundedGame,
  154: HugeIcons.strokeRoundedGameboy,
  155: HugeIcons.strokeRoundedAircraftGame,
  156: HugeIcons.strokeRoundedAiGame,
  157: HugeIcons.strokeRoundedGameController01,
  158: HugeIcons.strokeRoundedSingLeft,
  159: HugeIcons.strokeRoundedMusicNote02,
  160: HugeIcons.strokeRoundedMusicNote03,
  161: HugeIcons.strokeRoundedVynil01,
  162: HugeIcons.strokeRoundedVynil03,
  163: HugeIcons.strokeRoundedCanvas,
  164: HugeIcons.strokeRoundedBrush,
  165: HugeIcons.strokeRoundedVideo01,
  166: HugeIcons.strokeRoundedVideo02,
  167: HugeIcons.strokeRoundedCameraVideo,
  168: HugeIcons.strokeRoundedComputerVideo,
  169: HugeIcons.strokeRoundedVideoReplay,
  170: HugeIcons.strokeRoundedBubbleChatFavourite,
  171: HugeIcons.strokeRoundedMailLove01,
  172: HugeIcons.strokeRoundedInLove,
  173: HugeIcons.strokeRoundedKissing,
  174: HugeIcons.strokeRoundedFavouriteSquare,
  175: HugeIcons.strokeRoundedFavouriteCircle,
  176: HugeIcons.strokeRoundedHealth,
  177: HugeIcons.strokeRoundedHealtcare,
  178: HugeIcons.strokeRoundedFavourite,
  179: HugeIcons.strokeRoundedHeartCheck,
  180: HugeIcons.strokeRoundedAttachment,
  181: HugeIcons.strokeRoundedMoney03,
  182: HugeIcons.strokeRoundedSaveMoneyYen,
  183: HugeIcons.strokeRoundedSaveMoneyPound,
  184: HugeIcons.strokeRoundedSaveMoneyEuro,
  185: HugeIcons.strokeRoundedSaveMoneyDollar,
  186: HugeIcons.strokeRoundedMoneyBag01,
  187: HugeIcons.strokeRoundedCoins01,
  188: HugeIcons.strokeRoundedComputerDollar,
  189: HugeIcons.strokeRoundedWalletDone02,
  190: HugeIcons.strokeRoundedCreditCardPos,
  191: HugeIcons.strokeRoundedMoneyNotFound03,
  192: HugeIcons.strokeRoundedWallet02,
  193: HugeIcons.strokeRoundedSujood,
  194: HugeIcons.strokeRoundedWrench01,
  195: CommunityMaterialIcons.asterisk
};
