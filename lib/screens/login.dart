import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/provider/auth_provider.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';

import '../router/router.gr.dart';
import '../widgets/buttons/right_arrow_button.dart';
import '../widgets/login/bottom_shape.dart';
import '../widgets/login/top_shape.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(
        emailController: _emailController,
        passwordController: _passwordController,
        onLoginPress: () async {
          final auth = GetIt.I.get<AuthProvider>();
          await auth.signIn(_emailController.text, _passwordController.text);
          if (auth.isConnected()) {
            // ignore: use_build_context_synchronously
            AutoRouter.of(context).navigate(const HomeScreenRoute());
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login failed'),
              ),
            );
          }
        },
        onRegisterPress: () =>
            AutoRouter.of(context).navigate(const RegisterScreenRoute()),
      ),
    );
  }
}

class Login extends StatelessWidget {
  final void Function()? onLoginPress;
  final void Function()? onRegisterPress;
  final double screenWidth;
  final TextEditingController? _emailController;
  final TextEditingController? _passwordController;

  const Login({
    this.onLoginPress,
    this.onRegisterPress,
    this.screenWidth = 0,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    Key? key,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        screenWidth == 0 ? MediaQuery.of(context).size.width : screenWidth;
    final background = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPaint(
          size: Size(
            width,
            width * 0.48333333333333334,
          ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: const TopShape(),
        ),
        CustomPaint(
          size: Size(
            width,
            width * 0.5083333333333333,
          ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: const BottomShape(),
        ),
      ],
    );
    return Stack(
      children: [
        background,
        Column(
          children: [
            SizedBox(height: width * 0.2),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.orange,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome...',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            'Please sign in to continue',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  MainTextField(
                    controller: _emailController,
                    name: 'Email',
                    icon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 20),
                  MainTextField(
                    controller: _passwordController,
                    name: 'Password',
                    icon: const Icon(Icons.lock_outlined),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RightArrowButton(text: 'LOGIN', onPressed: onLoginPress),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextButton(
                  onPressed: onRegisterPress,
                  child: Text(
                    'Sign up',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        )
      ],
    );
  }
}
