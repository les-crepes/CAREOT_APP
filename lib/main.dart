import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/api/firebase_file.dart';
import 'package:pdg_app/provider/auth_provider.dart';
import 'package:pdg_app/router/auth_gard.dart';
import 'package:pdg_app/router/chat_guard.dart';
import 'package:pdg_app/router/home_guard.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/theme.dart';
import 'package:provider/provider.dart';
import 'api/firebase_connection.dart';
import 'api/firebase_user.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Setups everything before the app shows
Future<void> setup() async {
  await dotenv.load(fileName: ".env");

  final getIt = GetIt.instance;

  getIt.registerSingleton<AuthProvider>(
    AuthProvider(
      auth: FirebaseConnection(),
      clientApi: FirebaseUser(FirebaseFirestore.instance),
      fileApi: FirebaseFile(FirebaseStorage.instance),
    ),
  );
  await GetIt.I.get<AuthProvider>().init();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);
  await setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(
    authGuard: AuthGuard(),
    chatGuard: ChatGuard(),
    homeGuard: HomeGuard(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Careot',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      builder: (context, child) {
        if (child == null) return Container();
        return SafeArea(
          child: ChangeNotifierProvider.value(
            value: GetIt.I.get<AuthProvider>(),
            child: Container(
              color: Colors.white,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
