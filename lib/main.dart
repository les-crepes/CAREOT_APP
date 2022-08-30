import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

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
