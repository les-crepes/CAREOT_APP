import 'package:auto_route/auto_route.dart';

class AuthGard extends AutoRouteGuard {
  var isAuthenticated = false;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    //TODO à faire

    // if (!isAuthenticated) {
    //   router.pushAndPopUntil(
    //     LoginScreenRoute(onLoginResult: (_) {
    //       isAuthenticated = true;
    //       // we can't pop the bottom page in the navigator's stack
    //       // so we just remove it from our local stack
    //       resolver.next();
    //       router.removeLast();
    //     }),
    //     predicate: (r) => true,);
    // }
  }
}
