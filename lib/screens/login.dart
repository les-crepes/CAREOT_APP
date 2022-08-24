import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/screens/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Login(
        onLoginPress: () =>
            AutoRouter.of(context).navigate(const RegisterScreenRoute()));
  }
}

class Login extends StatelessWidget {
  final void Function()? onLoginPress;

  const Login({
    this.onLoginPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (onLoginPress != null) onLoginPress!();
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
