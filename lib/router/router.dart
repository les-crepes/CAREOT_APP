import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/home.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/home',
      page: HomeScreen,
      children: [],
    ),
    AutoRoute(
      page: ChatScreen,
      path: '/chat',
      initial: true,
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
      redirectTo: '/home',
    ),
  ],
)
class $AppRouter {}
