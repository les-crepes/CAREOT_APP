import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/provider/auth_provider.dart';
import 'package:pdg_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatRouterPage extends StatelessWidget {
  const ChatRouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(GetIt.I.get<AuthProvider>()),
      child: const AutoRouter(),
    );
  }
}
