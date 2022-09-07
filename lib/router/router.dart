import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:pdg_app/router/chat_guard.dart';
import 'package:pdg_app/screens/add_meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/client_list.dart';
import 'package:pdg_app/screens/client_record.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/discussion_list.dart';
import 'package:pdg_app/screens/document_list.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/screens/profile.dart';
import 'package:pdg_app/screens/register.dart';
import 'package:pdg_app/widgets/register/register_first_page.dart';
import 'package:pdg_app/widgets/register/register_second_page.dart';
import 'package:tuple/tuple.dart';

import '../model/meal.dart';
import '../screens/home.dart';
import '../widgets/register/register_third_page.dart';
import '../screens/update_client_record.dart';
import './auth_gard.dart';
import 'chat_router_page.dart';
import 'home_guard.dart';

// This file is used to generate the router.gr.dart file.
@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/home',
      page: HomeScreen,
      guards: [AuthGuard],
      initial: true,
      children: [
        AutoRoute(
          page: ChatRouterPage,
          name: 'ChatRouterPage',
          path: 'chat',
          children: [
            AutoRoute(
              page: ChatScreen,
              path: 'onechat',
            ),
            AutoRoute(
              page: DiscussionListScreen,
              path: 'chats',
              initial: true,
              guards: [ChatGuard],
            ),
            AutoRoute(
              page: DocumentListScreen,
              path: 'documents',
            ),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: "MainRouterPage",
          initial: true,
          path: 'main',
          children: [
            AutoRoute(
                page: EmptyRouterPage,
                name: 'ClientListRouter',
                path: 'clients',
                initial: true,
                guards: [
                  HomeGuard
                ],
                children: [
                  AutoRoute(
                    page: ClientListScreen,
                    path: '',
                  ),
                  AutoRoute(
                    page: ClientRecordScreen,
                    path: 'record',
                  ),
                  AutoRoute<Aftercare?>(
                    page: UpdateClientRecordScreen,
                    path: 'update',
                  )
                ]),
            AutoRoute(
              page: EmptyRouterPage,
              name: 'DiaryRouterPage',
              path: 'diary',
              children: [
                AutoRoute(
                  path: '',
                  page: DiaryScreen,
                ),
                AutoRoute<Tuple2<Meal?, XFile?>>(
                  path: 'add',
                  page: AddMealScreen,
                ),
              ],
            ),
          ],
        ),
        AutoRoute(
          page: ProfileScreen,
          path: 'my',
        )
      ],
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/login',
      initial: false,
    ),
    AutoRoute(
      page: RegisterScreen,
      path: '/register',
      children: [
        CustomRoute(
          page: RegisterFirstPage,
          path: '',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: RegisterSecondPage,
          path: '1',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: RegisterThirdPage,
          path: '2',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ],
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/home/diary',
    ),
  ],
)
class $AppRouter {}
