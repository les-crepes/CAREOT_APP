import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:pdg_app/screens/add_meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/profile.dart';
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
          page: EmptyRouterPage,
          name: "DiaryRouterPage",
          path: 'diary',
          children: [
            AutoRoute(
              path: '',
              page: DiaryScreen,
            ),
            AutoRoute(
              path: 'add',
              page: AddMealScreen,
            ),
          ],
        ),
        AutoRoute(
          page: ProfileScreen,
          path: 'my',
        )
      ],
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
    RedirectRoute(
      path: '*',
      redirectTo: '/home/diary',
    ),
  ],
)
class $AppRouter {}
