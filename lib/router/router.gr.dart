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
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i12;

import '../screens/add_meal.dart' as _i10;
import '../screens/chat.dart' as _i6;
import '../screens/diary.dart' as _i9;
import '../screens/discussion_list.dart' as _i7;
import '../screens/document_list.dart' as _i8;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i5;
import '../screens/register.dart' as _i3;
import 'auth_gard.dart' as _i13;
import 'chat_guard.dart' as _i14;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.chatGuard})
      : super(navigatorKey);

  final _i13.AuthGuard authGuard;

  final _i14.ChatGuard chatGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatRouterPage.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    DiaryRouterPage.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ProfileScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatScreen());
    },
    DiscussionListScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.DiscussionListScreen());
    },
    DocumentListScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DocumentListScreen());
    },
    DiaryScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.AddMealScreen());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i11.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i11.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i11.RouteConfig(ChatRouterPage.name,
              path: 'chat',
              parent: HomeScreenRoute.name,
              children: [
                _i11.RouteConfig('#redirect',
                    path: '',
                    parent: ChatRouterPage.name,
                    redirectTo: 'chats',
                    fullMatch: true),
                _i11.RouteConfig(ChatScreenRoute.name,
                    path: 'onechat', parent: ChatRouterPage.name),
                _i11.RouteConfig(DiscussionListScreenRoute.name,
                    path: 'chats',
                    parent: ChatRouterPage.name,
                    guards: [chatGuard]),
                _i11.RouteConfig(DocumentListScreenRoute.name,
                    path: 'documents', parent: ChatRouterPage.name)
              ]),
          _i11.RouteConfig(DiaryRouterPage.name,
              path: 'diary',
              parent: HomeScreenRoute.name,
              children: [
                _i11.RouteConfig(DiaryScreenRoute.name,
                    path: '', parent: DiaryRouterPage.name),
                _i11.RouteConfig(AddMealScreenRoute.name,
                    path: 'add', parent: DiaryRouterPage.name)
              ]),
          _i11.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i11.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i11.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i11.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i11.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i11.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i11.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ChatRouterPage extends _i11.PageRouteInfo<void> {
  const ChatRouterPage({List<_i11.PageRouteInfo>? children})
      : super(ChatRouterPage.name, path: 'chat', initialChildren: children);

  static const String name = 'ChatRouterPage';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class DiaryRouterPage extends _i11.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i11.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileScreenRoute extends _i11.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i6.ChatScreen]
class ChatScreenRoute extends _i11.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'onechat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i7.DiscussionListScreen]
class DiscussionListScreenRoute extends _i11.PageRouteInfo<void> {
  const DiscussionListScreenRoute()
      : super(DiscussionListScreenRoute.name, path: 'chats');

  static const String name = 'DiscussionListScreenRoute';
}

/// generated route for
/// [_i8.DocumentListScreen]
class DocumentListScreenRoute extends _i11.PageRouteInfo<void> {
  const DocumentListScreenRoute()
      : super(DocumentListScreenRoute.name, path: 'documents');

  static const String name = 'DocumentListScreenRoute';
}

/// generated route for
/// [_i9.DiaryScreen]
class DiaryScreenRoute extends _i11.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i10.AddMealScreen]
class AddMealScreenRoute extends _i11.PageRouteInfo<void> {
  const AddMealScreenRoute() : super(AddMealScreenRoute.name, path: 'add');

  static const String name = 'AddMealScreenRoute';
}
