import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/provider/auth_provider.dart';
import 'package:pdg_app/router/auth_gard.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/theme.dart';
import 'api/firebase_user.dart';
import 'api/firebase_connection.dart';
import 'firebase_options.dart';

Future<void> setup() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<AuthProvider>(
    AuthProvider(
      auth: FirebaseConnection(),
      clientApi: FirebaseUser(FirebaseFirestore.instance),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(authGuard: AuthGuard());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Careot',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
