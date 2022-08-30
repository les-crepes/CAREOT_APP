import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/add_meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

import '../screens/time_picker.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/diary',
      page: DiaryScreen,
      initial: false,
      children: [],
    ),
    AutoRoute(
      page: ChatScreen,
      path: '/chat',
      initial: false,
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/login',
      initial: false,
    ),
    AutoRoute(
      page: RegisterScreen,
      path: '/register',
    ),
    AutoRoute(
      page: RouterTestScreen,
      path: '/add-meal',
      initial: true,
      children: [
        AutoRoute(
          page: AddMealScreen,
          path: '',
        ),
        AutoRoute(
          page: TimePickerDialog,
          path: 'time',
          fullscreenDialog: false,
          deferredLoading: false,
        ),
      ],
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/diary',
    ),
  ],
)
class $AppRouter {}
