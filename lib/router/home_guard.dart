import 'package:auto_route/auto_route.dart';
import 'package:pdg_app/router/router.gr.dart';

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Cette variable sera modifié par la valeur qui indique si c'est un client ou non.
    const bool isClient = false;

    // ignore: dead_code
    if (!isClient) {
      resolver.next(true);
      // ignore: dead_code
    } else {
      router.push(const DiaryRouterPage());
    }
  }
}
