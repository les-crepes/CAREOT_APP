import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/register.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Login, initial: true),
    AutoRoute(page: Register),
  ],
)
class $AppRouter {}
