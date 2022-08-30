import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/custom_icon_button.dart';

import '../provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomIconButton(
      icon: Icons.logout,
      onTap: () {
        GetIt.I.get<AuthProvider>().signOut();
        AutoRouter.of(context).navigate(const LoginScreenRoute());
      },
    ));
  }
}
