// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/register.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeScreenRoute.name, path: '/'),
        _i4.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i4.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i4.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute() : super(HomeScreenRoute.name, path: '/');

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i4.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i4.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}
