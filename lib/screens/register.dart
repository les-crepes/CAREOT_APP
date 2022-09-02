import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/provider/register_provider.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/register/top_shape.dart';
import 'package:pdg_app/widgets/register/bottom_shape.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';
import 'package:provider/provider.dart';

import '../router/router.gr.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Register(
        onRegisterPress: () =>
            AutoRouter.of(context).navigate(const RegisterScreenRoute()),
      ),
    );

    /// Navigating to the RegisterScreenRoute.
  }
}

class Register extends StatelessWidget {
  final void Function()? onRegisterPress;
  final double screenWidth;

  const Register({
    this.screenWidth = 0,
    this.onRegisterPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        screenWidth == 0 ? MediaQuery.of(context).size.width : screenWidth;
    final items = [
      const MainTextField(name: 'Email', icon: Icon(Icons.email_outlined)),
      const MainTextField(name: 'Password', icon: Icon(Icons.lock_outline)),
      const MainTextField(
          name: 'Confirm password', icon: Icon(Icons.lock_outline)),
      RightArrowButton(text: 'REGISTER', onPressed: onRegisterPress),
    ];

    return Stack(
      children: [
        Column(
          children: [
            CustomPaint(
              size: Size(
                  width,
                  (width * 0.16944444444444445)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: TopShape(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Create account',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => RegisterProvider(),
                child: const AutoRouter(),
              ),
            ),
            CustomPaint(
              size: Size(
                  width,
                  (width * 0.21944444444444444)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: BottomShape(),
            ),
          ],
        )
      ],
    );
  }
}
