import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:pdg_app/router/chat_guard.dart';
import 'package:pdg_app/screens/add_meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/client_list.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/discussion_list.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/profile.dart';
import 'package:pdg_app/screens/register.dart';

import '../screens/home.dart';
import './auth_gard.dart';
import 'home_guard.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/home',
      page: HomeScreen,
      guards: [AuthGuard],
      initial: true,
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'diary',
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ChatRouterPage',
          path: 'chat',
          children: [
            AutoRoute(
              page: ChatScreen,
              path: 'onechat',
            ),
            AutoRoute(
                page: DiscussionListScreen,
                path: 'chats',
                initial: true,
                guards: [ChatGuard]),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: "MainRouterPage",
          path: 'main',
          children: [
            AutoRoute(
              page: ClientListScreen,
              path: 'clients',
              guards: [HomeGuard],
              initial: true,
            ),
            AutoRoute(
              page: EmptyRouterPage,
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
