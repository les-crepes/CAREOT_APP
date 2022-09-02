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
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i17;

import '../model/meal.dart' as _i21;
import '../model/user.dart' as _i22;
import '../screens/add_meal.dart' as _i12;
import '../screens/chat.dart' as _i6;
import '../screens/client_list.dart' as _i9;
import '../screens/client_record.dart' as _i10;
import '../screens/diary.dart' as _i11;
import '../screens/discussion_list.dart' as _i7;
import '../screens/document_list.dart' as _i8;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i5;
import '../screens/register.dart' as _i3;
import '../widgets/register/register_first_page.dart' as _i13;
import '../widgets/register/register_second_page.dart' as _i14;
import '../widgets/register/register_third_page.dart' as _i15;
import 'auth_gard.dart' as _i18;
import 'chat_guard.dart' as _i19;
import 'home_guard.dart' as _i20;

class AppRouter extends _i16.RootStackRouter {
  AppRouter(
      {_i17.GlobalKey<_i17.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.chatGuard,
      required this.homeGuard})
      : super(navigatorKey);

  final _i18.AuthGuard authGuard;

  final _i19.ChatGuard chatGuard;

  final _i20.HomeGuard homeGuard;

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatRouterPage.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    MainRouterPage.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ProfileScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatScreen());
    },
    DiscussionListScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.DiscussionListScreen());
    },
    DocumentListScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DocumentListScreen());
    },
    ClientListRouter.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    DiaryRouterPage.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ClientListScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ClientListScreen());
    },
    ClientRecordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ClientRecordScreenRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.ClientRecordScreen(user: args.user, key: args.key));
    },
    DiaryScreenRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddMealScreenRouteArgs>();
      return _i16.MaterialPageX<_i21.Meal?>(
          routeData: routeData,
          child: _i12.AddMealScreen(day: args.day, key: args.key));
    },
    RegisterFirstPageRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.RegisterFirstPage());
    },
    RegisterSecondPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterSecondPageRouteArgs>(
          orElse: () => const RegisterSecondPageRouteArgs());
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.RegisterSecondPage(key: args.key));
    },
    RegisterThirdPageRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.RegisterThirdPage());
    }
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i16.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i16.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i16.RouteConfig(ChatRouterPage.name,
              path: 'chat',
              parent: HomeScreenRoute.name,
              children: [
                _i16.RouteConfig('#redirect',
                    path: '',
                    parent: ChatRouterPage.name,
                    redirectTo: 'chats',
                    fullMatch: true),
                _i16.RouteConfig(ChatScreenRoute.name,
                    path: 'onechat', parent: ChatRouterPage.name),
                _i16.RouteConfig(DiscussionListScreenRoute.name,
                    path: 'chats',
                    parent: ChatRouterPage.name,
                    guards: [chatGuard]),
                _i16.RouteConfig(DocumentListScreenRoute.name,
                    path: 'documents', parent: ChatRouterPage.name)
              ]),
          _i16.RouteConfig(MainRouterPage.name,
              path: 'main',
              parent: HomeScreenRoute.name,
              children: [
                _i16.RouteConfig('#redirect',
                    path: '',
                    parent: MainRouterPage.name,
                    redirectTo: 'clients',
                    fullMatch: true),
                _i16.RouteConfig(ClientListRouter.name,
                    path: 'clients',
                    parent: MainRouterPage.name,
                    guards: [
                      homeGuard
                    ],
                    children: [
                      _i16.RouteConfig(ClientListScreenRoute.name,
                          path: '', parent: ClientListRouter.name),
                      _i16.RouteConfig(ClientRecordScreenRoute.name,
                          path: 'record', parent: ClientListRouter.name)
                    ]),
                _i16.RouteConfig(DiaryRouterPage.name,
                    path: 'diary',
                    parent: MainRouterPage.name,
                    children: [
                      _i16.RouteConfig(DiaryScreenRoute.name,
                          path: '', parent: DiaryRouterPage.name),
                      _i16.RouteConfig(AddMealScreenRoute.name,
                          path: 'add', parent: DiaryRouterPage.name)
                    ])
              ]),
          _i16.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i16.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i16.RouteConfig(RegisterScreenRoute.name,
            path: '/register',
            children: [
              _i16.RouteConfig(RegisterFirstPageRoute.name,
                  path: '', parent: RegisterScreenRoute.name),
              _i16.RouteConfig(RegisterSecondPageRoute.name,
                  path: '1', parent: RegisterScreenRoute.name),
              _i16.RouteConfig(RegisterThirdPageRoute.name,
                  path: '2', parent: RegisterScreenRoute.name)
            ]),
        _i16.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i16.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i16.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i16.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(RegisterScreenRoute.name,
            path: '/register', initialChildren: children);

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ChatRouterPage extends _i16.PageRouteInfo<void> {
  const ChatRouterPage({List<_i16.PageRouteInfo>? children})
      : super(ChatRouterPage.name, path: 'chat', initialChildren: children);

  static const String name = 'ChatRouterPage';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class MainRouterPage extends _i16.PageRouteInfo<void> {
  const MainRouterPage({List<_i16.PageRouteInfo>? children})
      : super(MainRouterPage.name, path: 'main', initialChildren: children);

  static const String name = 'MainRouterPage';
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileScreenRoute extends _i16.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i6.ChatScreen]
class ChatScreenRoute extends _i16.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'onechat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i7.DiscussionListScreen]
class DiscussionListScreenRoute extends _i16.PageRouteInfo<void> {
  const DiscussionListScreenRoute()
      : super(DiscussionListScreenRoute.name, path: 'chats');

  static const String name = 'DiscussionListScreenRoute';
}

/// generated route for
/// [_i8.DocumentListScreen]
class DocumentListScreenRoute extends _i16.PageRouteInfo<void> {
  const DocumentListScreenRoute()
      : super(DocumentListScreenRoute.name, path: 'documents');

  static const String name = 'DocumentListScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClientListRouter extends _i16.PageRouteInfo<void> {
  const ClientListRouter({List<_i16.PageRouteInfo>? children})
      : super(ClientListRouter.name,
            path: 'clients', initialChildren: children);

  static const String name = 'ClientListRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class DiaryRouterPage extends _i16.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i16.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i9.ClientListScreen]
class ClientListScreenRoute extends _i16.PageRouteInfo<void> {
  const ClientListScreenRoute() : super(ClientListScreenRoute.name, path: '');

  static const String name = 'ClientListScreenRoute';
}

/// generated route for
/// [_i10.ClientRecordScreen]
class ClientRecordScreenRoute
    extends _i16.PageRouteInfo<ClientRecordScreenRouteArgs> {
  ClientRecordScreenRoute({required _i22.User user, _i17.Key? key})
      : super(ClientRecordScreenRoute.name,
            path: 'record',
            args: ClientRecordScreenRouteArgs(user: user, key: key));

  static const String name = 'ClientRecordScreenRoute';
}

class ClientRecordScreenRouteArgs {
  const ClientRecordScreenRouteArgs({required this.user, this.key});

  final _i22.User user;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ClientRecordScreenRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i11.DiaryScreen]
class DiaryScreenRoute extends _i16.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i12.AddMealScreen]
class AddMealScreenRoute extends _i16.PageRouteInfo<AddMealScreenRouteArgs> {
  AddMealScreenRoute({required DateTime day, _i17.Key? key})
      : super(AddMealScreenRoute.name,
            path: 'add', args: AddMealScreenRouteArgs(day: day, key: key));

  static const String name = 'AddMealScreenRoute';
}

class AddMealScreenRouteArgs {
  const AddMealScreenRouteArgs({required this.day, this.key});

  final DateTime day;

  final _i17.Key? key;

  @override
  String toString() {
    return 'AddMealScreenRouteArgs{day: $day, key: $key}';
  }
}

/// generated route for
/// [_i13.RegisterFirstPage]
class RegisterFirstPageRoute extends _i16.PageRouteInfo<void> {
  const RegisterFirstPageRoute() : super(RegisterFirstPageRoute.name, path: '');

  static const String name = 'RegisterFirstPageRoute';
}

/// generated route for
/// [_i14.RegisterSecondPage]
class RegisterSecondPageRoute
    extends _i16.PageRouteInfo<RegisterSecondPageRouteArgs> {
  RegisterSecondPageRoute({_i17.Key? key})
      : super(RegisterSecondPageRoute.name,
            path: '1', args: RegisterSecondPageRouteArgs(key: key));

  static const String name = 'RegisterSecondPageRoute';
}

class RegisterSecondPageRouteArgs {
  const RegisterSecondPageRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'RegisterSecondPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.RegisterThirdPage]
class RegisterThirdPageRoute extends _i16.PageRouteInfo<void> {
  const RegisterThirdPageRoute()
      : super(RegisterThirdPageRoute.name, path: '2');

  static const String name = 'RegisterThirdPageRoute';
}
