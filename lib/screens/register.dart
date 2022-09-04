import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/provider/register_provider.dart';
import 'package:pdg_app/widgets/register/top_shape.dart';
import 'package:pdg_app/widgets/register/bottom_shape.dart';
import 'package:provider/provider.dart';

import '../widgets/loading_overlay.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      builder: (context, child) {
        return Scaffold(
          body: LoadingOverlay(
            controller: context.read<RegisterProvider>().loadingController,
            child: const Register(),
          ),
        );
      },
    );

    /// Navigating to the RegisterScreenRoute.
  }
}

class Register extends StatelessWidget {
  final double screenWidth;

  const Register({
    this.screenWidth = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        screenWidth == 0 ? MediaQuery.of(context).size.width : screenWidth;

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
            const Expanded(
              child: AutoRouter(),
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
