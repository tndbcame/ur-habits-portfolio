enum RouterEnums {
  root,
  login,
  rename,
  repassword,
  title,
  unregister,
  habitDetails,
  deadline,
  goalDetails,
  icons,
  habitRecord,
  setting,
  urHabitsTutorial,
}

extension RouterExtension on RouterEnums {
  static const Map<RouterEnums, String> _names = {
    RouterEnums.root: 'tab',
    RouterEnums.login: 'login',
    RouterEnums.rename: 'rename',
    RouterEnums.repassword: 'repassword',
    RouterEnums.title: 'title',
    RouterEnums.unregister: 'unregister',
    RouterEnums.habitDetails: 'habit-details',
    RouterEnums.deadline: 'deadline',
    RouterEnums.goalDetails: 'goal-details',
    RouterEnums.icons: 'icons',
    RouterEnums.habitRecord: 'habit-record',
    RouterEnums.setting: 'setting',
    RouterEnums.urHabitsTutorial: 'ur-habits-tutorial',
  };

  static const Map<RouterEnums, String> _paths = {
    RouterEnums.root: '/',
    RouterEnums.rename: '/setting/rename',
    RouterEnums.repassword: '/setting/repassword',
    RouterEnums.title: '/setting/title',
    RouterEnums.login: '/setting/title/login',
    RouterEnums.unregister: '/setting/unregister',
    RouterEnums.habitDetails: '/habit-details',
    RouterEnums.icons: '/habit-details/icons',
    RouterEnums.goalDetails: '/habit-details/goal-details',
    RouterEnums.deadline: '/habit-details/goal-details/deadline',
    RouterEnums.habitRecord: '/habit-record',
    RouterEnums.setting: '/setting',
    RouterEnums.urHabitsTutorial: '/ur-habits-tutorial',
  };

  String get names => _names[this] ?? '';
  String get paths => _paths[this] ?? '';
}
