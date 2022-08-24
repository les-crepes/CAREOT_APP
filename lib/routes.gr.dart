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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'screens/login.dart' as _i1;
import 'screens/register.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Login());
    },
    Register.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Register());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(Login.name, path: '/'),
        _i3.RouteConfig(Register.name, path: '/Register')
      ];
}

/// generated route for
/// [_i1.Login]
class Login extends _i3.PageRouteInfo<void> {
  const Login() : super(Login.name, path: '/');

  static const String name = 'Login';
}

/// generated route for
/// [_i2.Register]
class Register extends _i3.PageRouteInfo<void> {
  const Register() : super(Register.name, path: '/Register');

  static const String name = 'Register';
}
