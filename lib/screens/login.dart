import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/login/top_shape.dart';

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
              child: CustomPaint(
                size: Size(
                    300,
                    (300 * 0.48333333333333334)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
