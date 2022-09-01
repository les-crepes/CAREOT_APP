import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/router/router.gr.dart';

import '../provider/auth_provider.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I.get<AuthProvider>().isConnected()) {
      resolver.next(true);
    } else {
      router.push(const LoginScreenRoute());
    }
  }
}
