import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

import '../screens/home.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/home',
      page: HomeScreen,
      initial: true,
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'diary',
        ),
        AutoRoute(
          page: ChatScreen,
          path: 'chat',
        ),
        AutoRoute(
          page: DiaryScreen,
          path: 'diary',
        )
      ],
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/login',
    ),
    AutoRoute(
      page: RegisterScreen,
      path: '/register',
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/home/diary',
    ),
  ],
)
class $AppRouter {}
