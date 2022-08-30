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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:flutter/material.dart' as _i10;

import '../screens/add_meal.dart' as _i8;
import '../screens/chat.dart' as _i4;
import '../screens/diary.dart' as _i7;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i6;
import '../screens/register.dart' as _i3;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ChatScreen());
    },
    DiaryRouterPage.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProfileScreen());
    },
    DiaryScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.AddMealScreen());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i9.RouteConfig(HomeScreenRoute.name, path: '/home', children: [
          _i9.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i9.RouteConfig(ChatScreenRoute.name,
              path: 'chat', parent: HomeScreenRoute.name),
          _i9.RouteConfig(DiaryRouterPage.name,
              path: 'diary',
              parent: HomeScreenRoute.name,
              children: [
                _i9.RouteConfig(DiaryScreenRoute.name,
                    path: '', parent: DiaryRouterPage.name),
                _i9.RouteConfig(AddMealScreenRoute.name,
                    path: 'add', parent: DiaryRouterPage.name)
              ]),
          _i9.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i9.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i9.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i9.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i9.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i9.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i9.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.ChatScreen]
class ChatScreenRoute extends _i9.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'chat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class DiaryRouterPage extends _i9.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i9.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileScreenRoute extends _i9.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i7.DiaryScreen]
class DiaryScreenRoute extends _i9.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i8.AddMealScreen]
class AddMealScreenRoute extends _i9.PageRouteInfo<void> {
  const AddMealScreenRoute() : super(AddMealScreenRoute.name, path: 'add');

  static const String name = 'AddMealScreenRoute';
}
