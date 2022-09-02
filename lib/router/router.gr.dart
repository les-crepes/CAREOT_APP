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
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i16;

import '../model/meal.dart' as _i20;
import '../screens/add_meal.dart' as _i11;
import '../screens/chat.dart' as _i6;
import '../screens/client_list.dart' as _i9;
import '../screens/diary.dart' as _i10;
import '../screens/discussion_list.dart' as _i7;
import '../screens/document_list.dart' as _i8;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i5;
import '../screens/register.dart' as _i3;
import '../widgets/register/register_first_page.dart' as _i12;
import '../widgets/register/register_second_page.dart' as _i13;
import '../widgets/register/register_third_page.dart' as _i14;
import 'auth_gard.dart' as _i17;
import 'chat_guard.dart' as _i18;
import 'home_guard.dart' as _i19;

class AppRouter extends _i15.RootStackRouter {
  AppRouter(
      {_i16.GlobalKey<_i16.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.chatGuard,
      required this.homeGuard})
      : super(navigatorKey);

  final _i17.AuthGuard authGuard;

  final _i18.ChatGuard chatGuard;

  final _i19.HomeGuard homeGuard;

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatRouterPage.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    MainRouterPage.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ProfileScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatScreen());
    },
    DiscussionListScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.DiscussionListScreen());
    },
    DocumentListScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DocumentListScreen());
    },
    ClientListScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ClientListScreen());
    },
    DiaryRouterPage.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    DiaryScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddMealScreenRouteArgs>();
      return _i15.MaterialPageX<_i20.Meal?>(
          routeData: routeData,
          child: _i11.AddMealScreen(day: args.day, key: args.key));
    },
    RegisterFirstPageRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.RegisterFirstPage());
    },
    RegisterSecondPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterSecondPageRouteArgs>(
          orElse: () => const RegisterSecondPageRouteArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.RegisterSecondPage(key: args.key));
    },
    RegisterThirdPageRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.RegisterThirdPage());
    }
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i15.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i15.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i15.RouteConfig(ChatRouterPage.name,
              path: 'chat',
              parent: HomeScreenRoute.name,
              children: [
                _i15.RouteConfig('#redirect',
                    path: '',
                    parent: ChatRouterPage.name,
                    redirectTo: 'chats',
                    fullMatch: true),
                _i15.RouteConfig(ChatScreenRoute.name,
                    path: 'onechat', parent: ChatRouterPage.name),
                _i15.RouteConfig(DiscussionListScreenRoute.name,
                    path: 'chats',
                    parent: ChatRouterPage.name,
                    guards: [chatGuard]),
                _i15.RouteConfig(DocumentListScreenRoute.name,
                    path: 'documents', parent: ChatRouterPage.name)
              ]),
          _i15.RouteConfig(MainRouterPage.name,
              path: 'main',
              parent: HomeScreenRoute.name,
              children: [
                _i15.RouteConfig('#redirect',
                    path: '',
                    parent: MainRouterPage.name,
                    redirectTo: 'clients',
                    fullMatch: true),
                _i15.RouteConfig(ClientListScreenRoute.name,
                    path: 'clients',
                    parent: MainRouterPage.name,
                    guards: [homeGuard]),
                _i15.RouteConfig(DiaryRouterPage.name,
                    path: 'diary',
                    parent: MainRouterPage.name,
                    children: [
                      _i15.RouteConfig(DiaryScreenRoute.name,
                          path: '', parent: DiaryRouterPage.name),
                      _i15.RouteConfig(AddMealScreenRoute.name,
                          path: 'add', parent: DiaryRouterPage.name)
                    ])
              ]),
          _i15.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i15.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i15.RouteConfig(RegisterScreenRoute.name,
            path: '/register',
            children: [
              _i15.RouteConfig(RegisterFirstPageRoute.name,
                  path: '', parent: RegisterScreenRoute.name),
              _i15.RouteConfig(RegisterSecondPageRoute.name,
                  path: '1', parent: RegisterScreenRoute.name),
              _i15.RouteConfig(RegisterThirdPageRoute.name,
                  path: '2', parent: RegisterScreenRoute.name)
            ]),
        _i15.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i15.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i15.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i15.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(RegisterScreenRoute.name,
            path: '/register', initialChildren: children);

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ChatRouterPage extends _i15.PageRouteInfo<void> {
  const ChatRouterPage({List<_i15.PageRouteInfo>? children})
      : super(ChatRouterPage.name, path: 'chat', initialChildren: children);

  static const String name = 'ChatRouterPage';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class MainRouterPage extends _i15.PageRouteInfo<void> {
  const MainRouterPage({List<_i15.PageRouteInfo>? children})
      : super(MainRouterPage.name, path: 'main', initialChildren: children);

  static const String name = 'MainRouterPage';
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileScreenRoute extends _i15.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i6.ChatScreen]
class ChatScreenRoute extends _i15.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'onechat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i7.DiscussionListScreen]
class DiscussionListScreenRoute extends _i15.PageRouteInfo<void> {
  const DiscussionListScreenRoute()
      : super(DiscussionListScreenRoute.name, path: 'chats');

  static const String name = 'DiscussionListScreenRoute';
}

/// generated route for
/// [_i8.DocumentListScreen]
class DocumentListScreenRoute extends _i15.PageRouteInfo<void> {
  const DocumentListScreenRoute()
      : super(DocumentListScreenRoute.name, path: 'documents');

  static const String name = 'DocumentListScreenRoute';
}

/// generated route for
/// [_i9.ClientListScreen]
class ClientListScreenRoute extends _i15.PageRouteInfo<void> {
  const ClientListScreenRoute()
      : super(ClientListScreenRoute.name, path: 'clients');

  static const String name = 'ClientListScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class DiaryRouterPage extends _i15.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i15.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i10.DiaryScreen]
class DiaryScreenRoute extends _i15.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i11.AddMealScreen]
class AddMealScreenRoute extends _i15.PageRouteInfo<AddMealScreenRouteArgs> {
  AddMealScreenRoute({required DateTime day, _i16.Key? key})
      : super(AddMealScreenRoute.name,
            path: 'add', args: AddMealScreenRouteArgs(day: day, key: key));

  static const String name = 'AddMealScreenRoute';
}

class AddMealScreenRouteArgs {
  const AddMealScreenRouteArgs({required this.day, this.key});

  final DateTime day;

  final _i16.Key? key;

  @override
  String toString() {
    return 'AddMealScreenRouteArgs{day: $day, key: $key}';
  }
}

/// generated route for
/// [_i12.RegisterFirstPage]
class RegisterFirstPageRoute extends _i15.PageRouteInfo<void> {
  const RegisterFirstPageRoute() : super(RegisterFirstPageRoute.name, path: '');

  static const String name = 'RegisterFirstPageRoute';
}

/// generated route for
/// [_i13.RegisterSecondPage]
class RegisterSecondPageRoute
    extends _i15.PageRouteInfo<RegisterSecondPageRouteArgs> {
  RegisterSecondPageRoute({_i16.Key? key})
      : super(RegisterSecondPageRoute.name,
            path: '1', args: RegisterSecondPageRouteArgs(key: key));

  static const String name = 'RegisterSecondPageRoute';
}

class RegisterSecondPageRouteArgs {
  const RegisterSecondPageRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'RegisterSecondPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.RegisterThirdPage]
class RegisterThirdPageRoute extends _i15.PageRouteInfo<void> {
  const RegisterThirdPageRoute()
      : super(RegisterThirdPageRoute.name, path: '2');

  static const String name = 'RegisterThirdPageRoute';
}
