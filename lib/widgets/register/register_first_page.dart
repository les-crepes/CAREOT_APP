import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../../provider/register_provider.dart';
import '../forms/main_text_field.dart';
import '../right_arrow_button.dart';

class RegisterFirstPage extends StatelessWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  List<Widget> buildInputs(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();
    return [
      MainTextField(
        name: 'Email',
        icon: const Icon(Icons.email),
        keyboardType: TextInputType.emailAddress,
        controller: registerProvider.emailController,
      ),
      MainTextField(
        name: 'Password',
        icon: const Icon(Icons.lock),
        obscureText: true,
        controller: registerProvider.passwordController,
      ),
      MainTextField(
        name: 'Confirm password',
        icon: const Icon(Icons.lock),
        controller: registerProvider.confirmPasswordController,
        obscureText: true,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            child: RightArrowButton(
              text: 'Next',
              onPressed: () =>
                  AutoRouter.of(context).push(RegisterSecondPageRoute()),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = buildInputs(context);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      separatorBuilder: (context, index) => const SizedBox(height: 30),
      itemCount: content.length,
      itemBuilder: (context, index) {
        return content[index];
      },
    );
  }
}
