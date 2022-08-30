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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screens/add_meal.dart' as _i5;
import '../screens/chat.dart' as _i2;
import '../screens/diary.dart' as _i1;
import '../screens/login.dart' as _i3;
import '../screens/register.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    DiaryScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.DiaryScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ChatScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AddMealScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/add-meal', fullMatch: true),
        _i6.RouteConfig(DiaryScreenRoute.name, path: '/diary'),
        _i6.RouteConfig(ChatScreenRoute.name, path: '/chat'),
        _i6.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i6.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i6.RouteConfig(AddMealScreenRoute.name, path: '/add-meal'),
        _i6.RouteConfig('*#redirect',
            path: '*', redirectTo: '/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.DiaryScreen]
class DiaryScreenRoute extends _i6.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '/diary');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i2.ChatScreen]
class ChatScreenRoute extends _i6.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: '/chat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i6.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i4.RegisterScreen]
class RegisterScreenRoute extends _i6.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i5.AddMealScreen]
class AddMealScreenRoute extends _i6.PageRouteInfo<void> {
  const AddMealScreenRoute()
      : super(AddMealScreenRoute.name, path: '/add-meal');

  static const String name = 'AddMealScreenRoute';
}
