import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/add_meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/diary',
      page: DiaryScreen,
      initial: true,
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
    ),
    AutoRoute(
      page: RegisterScreen,
      path: '/register',
    ),
    AutoRoute(
      page: AddMealScreen,
      path: '/add-meal',
      initial: true,
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/diary',
    ),
  ],
)
class $AppRouter {}
