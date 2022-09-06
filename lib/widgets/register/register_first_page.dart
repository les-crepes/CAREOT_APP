import 'package:auto_route/auto_route.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../../provider/register_provider.dart';
import '../forms/main_text_field.dart';
import '../buttons/right_arrow_button.dart';

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
        validator: validateEmail,
      ),
      MainTextField(
        name: 'Password',
        icon: const Icon(Icons.lock),
        obscureText: true,
        controller: registerProvider.passwordController,
        validator: validatePassword,
      ),
      MainTextField(
        name: 'Confirm password',
        icon: const Icon(Icons.lock),
        controller: registerProvider.confirmPasswordController,
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else if (registerProvider.passwordController.text != value) {
            return 'Password does not match';
          }
          return null;
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            child: RightArrowButton(
                text: 'Next',
                onPressed: () async {
                  if (registerProvider.formPage1.currentState!.validate()) {
                    if (await registerProvider.checkEmailValidity()) {
                      AutoRouter.of(context).push(RegisterSecondPageRoute());
                    } else {
                      final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          margin: const EdgeInsets.only(top: 5),
                          elevation: 0,
                          content: AwesomeSnackbarContent(
                            title: "Email already used",
                            message: "Sorry, this email is already in use...",
                            contentType: ContentType.failure,
                          ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                }),
          ),
        ],
      ),
    ];
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!value.isValidEmail()) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final content = buildInputs(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: context.read<RegisterProvider>().formPage1,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(height: 30),
        itemCount: content.length,
        itemBuilder: (context, index) {
          return content[index];
        },
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
