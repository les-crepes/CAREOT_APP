import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/router/router.gr.dart';

import '../provider/auth_provider.dart';

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Cette variable sera modifié par la valeur qui indique si c'est un client ou non.
    bool isAdmin = GetIt.I.get<AuthProvider>().isAdmin;

    // ignore: dead_code
    if (isAdmin) {
      resolver.next(true);
      // ignore: dead_code
    } else {
      router.push(const DiaryRouterPage());
    }
  }
}
