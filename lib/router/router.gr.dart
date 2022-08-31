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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:auto_route/empty_router_widgets.dart' as _i6;
import 'package:flutter/material.dart' as _i11;

import '../screens/add_meal.dart' as _i9;
import '../screens/chat.dart' as _i4;
import '../screens/client_list.dart' as _i5;
import '../screens/diary.dart' as _i8;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i7;
import '../screens/register.dart' as _i3;
import 'auth_gard.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i12.AuthGuard authGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ChatScreen());
    },
    ClientListScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ClientListScreen());
    },
    DiaryRouterPage.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProfileScreen());
    },
    DiaryScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.AddMealScreen());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i10.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i10.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i10.RouteConfig(ChatScreenRoute.name,
              path: 'chat', parent: HomeScreenRoute.name),
          _i10.RouteConfig(ClientListScreenRoute.name,
              path: 'client_list', parent: HomeScreenRoute.name),
          _i10.RouteConfig(DiaryRouterPage.name,
              path: 'diary',
              parent: HomeScreenRoute.name,
              children: [
                _i10.RouteConfig(DiaryScreenRoute.name,
                    path: '', parent: DiaryRouterPage.name),
                _i10.RouteConfig(AddMealScreenRoute.name,
                    path: 'add', parent: DiaryRouterPage.name)
              ]),
          _i10.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i10.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i10.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i10.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i10.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i10.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i10.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.ChatScreen]
class ChatScreenRoute extends _i10.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'chat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i5.ClientListScreen]
class ClientListScreenRoute extends _i10.PageRouteInfo<void> {
  const ClientListScreenRoute()
      : super(ClientListScreenRoute.name, path: 'client_list');

  static const String name = 'ClientListScreenRoute';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class DiaryRouterPage extends _i10.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i10.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileScreenRoute extends _i10.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i8.DiaryScreen]
class DiaryScreenRoute extends _i10.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i9.AddMealScreen]
class AddMealScreenRoute extends _i10.PageRouteInfo<void> {
  const AddMealScreenRoute() : super(AddMealScreenRoute.name, path: 'add');

  static const String name = 'AddMealScreenRoute';
}
