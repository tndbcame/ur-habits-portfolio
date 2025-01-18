import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/routers/router_data.dart';
import 'package:ur_habits/views/screens/auth/logins.dart';
import 'package:ur_habits/views/screens/auth/renames.dart';
import 'package:ur_habits/views/screens/auth/repaswords.dart';
import 'package:ur_habits/views/screens/auth/titles.dart';
import 'package:ur_habits/views/screens/auth/unregisters.dart';
import 'package:ur_habits/views/screens/habit_detail/deadlines.dart';
import 'package:ur_habits/views/screens/habit_detail/goal_details.dart';
import 'package:ur_habits/views/screens/habit_detail/habit_details.dart';
import 'package:ur_habits/views/screens/habit_detail/icons.dart';
import 'package:ur_habits/views/screens/habit_record/habit_records.dart';
import 'package:ur_habits/views/screens/setting/settings.dart';
import 'package:ur_habits/views/screens/tabs/tabs.dart';
import 'package:ur_habits/views/screens/tutorial/ur_habtis_tutorials.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouterEnums.root.paths,
  routes: [
    GoRoute(
      name: RouterEnums.root.names,
      path: RouterEnums.root.paths,
      builder: (context, state) {
        return const TabsScreen();
      },
      routes: [
        GoRoute(
            name: RouterEnums.setting.names,
            path: RouterEnums.root.paths + RouterEnums.setting.names,
            builder: (context, state) {
              final data = state.extra as SettingsData;
              return SettingScreen(key: data.key);
            },
            routes: [
              GoRoute(
                  name: RouterEnums.rename.names,
                  path: RouterEnums.root.paths + RouterEnums.rename.names,
                  builder: (context, state) {
                    final data = state.extra as RenamesData;
                    return RenameScreen(key: data.key, name: data.name);
                  }),
              GoRoute(
                  name: RouterEnums.repassword.names,
                  path: RouterEnums.root.paths + RouterEnums.repassword.names,
                  builder: (context, state) {
                    final data = state.extra as RepasswordsData;
                    return RepasswordScreen(
                      key: data.key,
                      title: data.title,
                      cationText: data.cationText,
                      appBarColor: data.appBarColor,
                      containerColor: data.containerColor,
                      backgroundColor: data.backgroundColor,
                      email: data.email,
                    );
                  }),
              GoRoute(
                  name: RouterEnums.unregister.names,
                  path: RouterEnums.root.paths + RouterEnums.unregister.names,
                  builder: (context, state) {
                    final data = state.extra as UnregistersData;
                    return UnregisterScreen(key: data.key);
                  }),
              GoRoute(
                  name: RouterEnums.title.names,
                  path: RouterEnums.root.paths + RouterEnums.title.names,
                  builder: (context, state) {
                    final data = state.extra as TitlesData;
                    return TitleScreen(key: data.key);
                  },
                  routes: [
                    GoRoute(
                        name: RouterEnums.login.names,
                        path: RouterEnums.root.paths + RouterEnums.login.names,
                        builder: (context, state) {
                          final data = state.extra as LoginsData;
                          return LoginScreen(
                              key: data.key, isLogin: data.isLogin);
                        }),
                  ]),
            ]),
        GoRoute(
            name: RouterEnums.habitDetails.names,
            path: RouterEnums.root.paths + RouterEnums.habitDetails.names,
            builder: (context, state) {
              final data = state.extra as HabitDetailsData;
              return HabitDetailsScreen(
                key: data.key,
                isUpdate: data.isUpdate,
                habit: data.habit,
                publicHabitsSize: data.publicHabitsSize,
              );
            },
            routes: [
              GoRoute(
                  name: RouterEnums.icons.names,
                  path: RouterEnums.root.paths + RouterEnums.icons.names,
                  builder: (context, state) {
                    final data = state.extra as IconsData;
                    return IconsScreen(key: data.key, iconId: data.iconId);
                  }),
              GoRoute(
                  name: RouterEnums.goalDetails.names,
                  path: RouterEnums.root.paths + RouterEnums.goalDetails.names,
                  builder: (context, state) {
                    final data = state.extra as GoalDetailsData;
                    return GoalDetailsScreen(
                      key: data.key,
                      selectedDataType: data.selectedDataType,
                      accumulationType: data.accumulationType,
                      isUpdate: data.isUpdate,
                      habitGoal: data.habitGoal,
                    );
                  },
                  routes: [
                    GoRoute(
                        name: RouterEnums.deadline.names,
                        path:
                            RouterEnums.root.paths + RouterEnums.deadline.names,
                        builder: (context, state) {
                          final data = state.extra as DeadlinesData;
                          return DeadlineScreen(
                              key: data.key, selectedDate: data.selectedDate);
                        }),
                  ]),
            ]),
        GoRoute(
            name: RouterEnums.habitRecord.names,
            path: RouterEnums.root.paths + RouterEnums.habitRecord.names,
            builder: (context, state) {
              final data = state.extra as HabitRecordsData;
              return HabitRecordScreen(
                key: data.key,
                habit: data.habit,
                ishome: data.ishome,
                readOnly: data.readOnly,
              );
            }),
        GoRoute(
            name: RouterEnums.urHabitsTutorial.names,
            path: RouterEnums.root.paths + RouterEnums.urHabitsTutorial.names,
            builder: (context, state) {
              final data = state.extra as UrHabitsTutorialsData;
              return UrHabitsTutorialScreen(key: data.key);
            }),
      ],
    ),
  ],
);
