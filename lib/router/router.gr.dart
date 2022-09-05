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
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:flutter/material.dart' as _i19;

import '../model/aftercare.dart' as _i23;
import '../model/meal.dart' as _i24;
import '../model/user.dart' as _i25;
import '../screens/add_meal.dart' as _i14;
import '../screens/chat.dart' as _i7;
import '../screens/client_list.dart' as _i10;
import '../screens/client_record.dart' as _i11;
import '../screens/diary.dart' as _i13;
import '../screens/discussion_list.dart' as _i8;
import '../screens/document_list.dart' as _i9;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i6;
import '../screens/register.dart' as _i3;
import '../screens/update_client_record.dart' as _i12;
import '../widgets/register/register_first_page.dart' as _i15;
import '../widgets/register/register_second_page.dart' as _i16;
import '../widgets/register/register_third_page.dart' as _i17;
import 'auth_gard.dart' as _i20;
import 'chat_guard.dart' as _i21;
import 'chat_router_page.dart' as _i4;
import 'home_guard.dart' as _i22;

class AppRouter extends _i18.RootStackRouter {
  AppRouter(
      {_i19.GlobalKey<_i19.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.chatGuard,
      required this.homeGuard})
      : super(navigatorKey);

  final _i20.AuthGuard authGuard;

  final _i21.ChatGuard chatGuard;

  final _i22.HomeGuard homeGuard;

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatRouterPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ChatRouterPage());
    },
    MainRouterPage.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProfileScreen());
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>(
          orElse: () => const ChatScreenRouteArgs());
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ChatScreen(key: args.key, otherUser: args.otherUser));
    },
    DiscussionListScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DiscussionListScreen());
    },
    DocumentListScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.DocumentListScreen());
    },
    ClientListRouter.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    DiaryRouterPage.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ClientListScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.ClientListScreen());
    },
    ClientRecordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ClientRecordScreenRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.ClientRecordScreen(user: args.user, key: args.key));
    },
    UpdateClientRecordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateClientRecordScreenRouteArgs>();
      return _i18.MaterialPageX<_i23.Aftercare?>(
          routeData: routeData,
          child: _i12.UpdateClientRecordScreen(
              user: args.user, aftercare: args.aftercare, key: args.key));
    },
    DiaryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DiaryScreenRouteArgs>(
          orElse: () => const DiaryScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.DiaryScreen(client: args.client, key: args.key));
    },
    AddMealScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddMealScreenRouteArgs>();
      return _i18.MaterialPageX<_i24.Meal?>(
          routeData: routeData,
          child: _i14.AddMealScreen(
              day: args.day, meal: args.meal, key: args.key));
    },
    RegisterFirstPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.RegisterFirstPage());
    },
    RegisterSecondPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterSecondPageRouteArgs>(
          orElse: () => const RegisterSecondPageRouteArgs());
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.RegisterSecondPage(key: args.key));
    },
    RegisterThirdPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.RegisterThirdPage());
    }
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i18.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i18.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'main',
              fullMatch: true),
          _i18.RouteConfig(ChatRouterPageRoute.name,
              path: 'chat',
              parent: HomeScreenRoute.name,
              children: [
                _i18.RouteConfig('#redirect',
                    path: '',
                    parent: ChatRouterPageRoute.name,
                    redirectTo: 'chats',
                    fullMatch: true),
                _i18.RouteConfig(ChatScreenRoute.name,
                    path: 'onechat', parent: ChatRouterPageRoute.name),
                _i18.RouteConfig(DiscussionListScreenRoute.name,
                    path: 'chats',
                    parent: ChatRouterPageRoute.name,
                    guards: [chatGuard]),
                _i18.RouteConfig(DocumentListScreenRoute.name,
                    path: 'documents', parent: ChatRouterPageRoute.name)
              ]),
          _i18.RouteConfig(MainRouterPage.name,
              path: 'main',
              parent: HomeScreenRoute.name,
              children: [
                _i18.RouteConfig('#redirect',
                    path: '',
                    parent: MainRouterPage.name,
                    redirectTo: 'clients',
                    fullMatch: true),
                _i18.RouteConfig(ClientListRouter.name,
                    path: 'clients',
                    parent: MainRouterPage.name,
                    guards: [
                      homeGuard
                    ],
                    children: [
                      _i18.RouteConfig(ClientListScreenRoute.name,
                          path: '', parent: ClientListRouter.name),
                      _i18.RouteConfig(ClientRecordScreenRoute.name,
                          path: 'record', parent: ClientListRouter.name),
                      _i18.RouteConfig(UpdateClientRecordScreenRoute.name,
                          path: 'update', parent: ClientListRouter.name)
                    ]),
                _i18.RouteConfig(DiaryRouterPage.name,
                    path: 'diary',
                    parent: MainRouterPage.name,
                    children: [
                      _i18.RouteConfig(DiaryScreenRoute.name,
                          path: '', parent: DiaryRouterPage.name),
                      _i18.RouteConfig(AddMealScreenRoute.name,
                          path: 'add', parent: DiaryRouterPage.name)
                    ])
              ]),
          _i18.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i18.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i18.RouteConfig(RegisterScreenRoute.name,
            path: '/register',
            children: [
              _i18.RouteConfig(RegisterFirstPageRoute.name,
                  path: '', parent: RegisterScreenRoute.name),
              _i18.RouteConfig(RegisterSecondPageRoute.name,
                  path: '1', parent: RegisterScreenRoute.name),
              _i18.RouteConfig(RegisterThirdPageRoute.name,
                  path: '2', parent: RegisterScreenRoute.name)
            ]),
        _i18.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i18.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i18.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i18.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i18.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i18.PageRouteInfo>? children})
      : super(RegisterScreenRoute.name,
            path: '/register', initialChildren: children);

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.ChatRouterPage]
class ChatRouterPageRoute extends _i18.PageRouteInfo<void> {
  const ChatRouterPageRoute({List<_i18.PageRouteInfo>? children})
      : super(ChatRouterPageRoute.name,
            path: 'chat', initialChildren: children);

  static const String name = 'ChatRouterPageRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class MainRouterPage extends _i18.PageRouteInfo<void> {
  const MainRouterPage({List<_i18.PageRouteInfo>? children})
      : super(MainRouterPage.name, path: 'main', initialChildren: children);

  static const String name = 'MainRouterPage';
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileScreenRoute extends _i18.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i7.ChatScreen]
class ChatScreenRoute extends _i18.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({_i19.Key? key, _i25.User? otherUser})
      : super(ChatScreenRoute.name,
            path: 'onechat',
            args: ChatScreenRouteArgs(key: key, otherUser: otherUser));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({this.key, this.otherUser});

  final _i19.Key? key;

  final _i25.User? otherUser;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, otherUser: $otherUser}';
  }
}

/// generated route for
/// [_i8.DiscussionListScreen]
class DiscussionListScreenRoute extends _i18.PageRouteInfo<void> {
  const DiscussionListScreenRoute()
      : super(DiscussionListScreenRoute.name, path: 'chats');

  static const String name = 'DiscussionListScreenRoute';
}

/// generated route for
/// [_i9.DocumentListScreen]
class DocumentListScreenRoute extends _i18.PageRouteInfo<void> {
  const DocumentListScreenRoute()
      : super(DocumentListScreenRoute.name, path: 'documents');

  static const String name = 'DocumentListScreenRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ClientListRouter extends _i18.PageRouteInfo<void> {
  const ClientListRouter({List<_i18.PageRouteInfo>? children})
      : super(ClientListRouter.name,
            path: 'clients', initialChildren: children);

  static const String name = 'ClientListRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class DiaryRouterPage extends _i18.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i18.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i10.ClientListScreen]
class ClientListScreenRoute extends _i18.PageRouteInfo<void> {
  const ClientListScreenRoute() : super(ClientListScreenRoute.name, path: '');

  static const String name = 'ClientListScreenRoute';
}

/// generated route for
/// [_i11.ClientRecordScreen]
class ClientRecordScreenRoute
    extends _i18.PageRouteInfo<ClientRecordScreenRouteArgs> {
  ClientRecordScreenRoute({required _i25.User user, _i19.Key? key})
      : super(ClientRecordScreenRoute.name,
            path: 'record',
            args: ClientRecordScreenRouteArgs(user: user, key: key));

  static const String name = 'ClientRecordScreenRoute';
}

class ClientRecordScreenRouteArgs {
  const ClientRecordScreenRouteArgs({required this.user, this.key});

  final _i25.User user;

  final _i19.Key? key;

  @override
  String toString() {
    return 'ClientRecordScreenRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i12.UpdateClientRecordScreen]
class UpdateClientRecordScreenRoute
    extends _i18.PageRouteInfo<UpdateClientRecordScreenRouteArgs> {
  UpdateClientRecordScreenRoute(
      {required dynamic user, _i23.Aftercare? aftercare, _i19.Key? key})
      : super(UpdateClientRecordScreenRoute.name,
            path: 'update',
            args: UpdateClientRecordScreenRouteArgs(
                user: user, aftercare: aftercare, key: key));

  static const String name = 'UpdateClientRecordScreenRoute';
}

class UpdateClientRecordScreenRouteArgs {
  const UpdateClientRecordScreenRouteArgs(
      {required this.user, this.aftercare, this.key});

  final dynamic user;

  final _i23.Aftercare? aftercare;

  final _i19.Key? key;

  @override
  String toString() {
    return 'UpdateClientRecordScreenRouteArgs{user: $user, aftercare: $aftercare, key: $key}';
  }
}

/// generated route for
/// [_i12.DiaryScreen]
class DiaryScreenRoute extends _i17.PageRouteInfo<DiaryScreenRouteArgs> {
  DiaryScreenRoute({_i24.User? client, _i18.Key? key})
      : super(DiaryScreenRoute.name,
            path: '', args: DiaryScreenRouteArgs(client: client, key: key));

  static const String name = 'DiaryScreenRoute';
}

class DiaryScreenRouteArgs {
  const DiaryScreenRouteArgs({this.client, this.key});

  final _i24.User? client;

  final _i18.Key? key;

  @override
  String toString() {
    return 'DiaryScreenRouteArgs{client: $client, key: $key}';
  }
}

/// generated route for
/// [_i14.AddMealScreen]
class AddMealScreenRoute extends _i18.PageRouteInfo<AddMealScreenRouteArgs> {
  AddMealScreenRoute({required DateTime day, _i24.Meal? meal, _i19.Key? key})
      : super(AddMealScreenRoute.name,
            path: 'add',
            args: AddMealScreenRouteArgs(day: day, meal: meal, key: key));

  static const String name = 'AddMealScreenRoute';
}

class AddMealScreenRouteArgs {
  const AddMealScreenRouteArgs({required this.day, this.meal, this.key});

  final DateTime day;

  final _i24.Meal? meal;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AddMealScreenRouteArgs{day: $day, meal: $meal, key: $key}';
  }
}

/// generated route for
/// [_i15.RegisterFirstPage]
class RegisterFirstPageRoute extends _i18.PageRouteInfo<void> {
  const RegisterFirstPageRoute() : super(RegisterFirstPageRoute.name, path: '');

  static const String name = 'RegisterFirstPageRoute';
}

/// generated route for
/// [_i16.RegisterSecondPage]
class RegisterSecondPageRoute
    extends _i18.PageRouteInfo<RegisterSecondPageRouteArgs> {
  RegisterSecondPageRoute({_i19.Key? key})
      : super(RegisterSecondPageRoute.name,
            path: '1', args: RegisterSecondPageRouteArgs(key: key));

  static const String name = 'RegisterSecondPageRoute';
}

class RegisterSecondPageRouteArgs {
  const RegisterSecondPageRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'RegisterSecondPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.RegisterThirdPage]
class RegisterThirdPageRoute extends _i18.PageRouteInfo<void> {
  const RegisterThirdPageRoute()
      : super(RegisterThirdPageRoute.name, path: '2');

  static const String name = 'RegisterThirdPageRoute';
}
