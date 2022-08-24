import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/home.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: LoginScreen,
      children: [],
    ),
    // AutoRoute(
    //   page: LoginScreen,
    //   path: '/login',
    //   initial: true,
    // ),
    AutoRoute(
      page: RegisterScreen,
      path: '/register',
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/',
    ),
  ],
)
class $AppRouter {}
