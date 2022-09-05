import 'dart:convert';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/auth_provider.dart';
import '../provider/chat_provider.dart';

String randomString() {
  final random = math.Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatScreen extends StatefulWidget {
  final User _otherUser;
  const ChatScreen({
    Key? key,
    required User otherUser,
  })  : _otherUser = otherUser,
        super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _mainUser = types.User(id: GetIt.I.get<AuthProvider>().userUid);

  @override
  void initState() {
    super.initState();
  }

  void _addMessage(types.Message message) {
    setState(() {
      //_messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _mainUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final ChatProvider chatProvider = context.watch<ChatProvider>();
    return ChatInterface(
      name: '${widget._otherUser.firstName} ${widget._otherUser.lastName}',
      currentUser: _mainUser,
      messages: chatProvider.messages[widget._otherUser]!
          .map((m) => types.TextMessage(
                id: m.uid,
                author: types.User(id: m.fromId),
                type: types.MessageType.text,
                text: m.content,
              ))
          .toList(),
      onSendPressed: _handleSendPressed,
      onDocumentPressed: () {
        AutoRouter.of(context).push(const DocumentListScreenRoute());
      },
    );
  }
}

class ChatInterface extends StatefulWidget {
  final String name;
  final types.User currentUser;
  final List<types.Message> messages;
  final void Function(types.PartialText) onSendPressed;
  final void Function()? _onDocumentPressed;

  const ChatInterface({
    required this.name,
    required this.currentUser,
    required this.messages,
    required this.onSendPressed,
    void Function()? onDocumentPressed,
    Key? key,
  })  : _onDocumentPressed = onDocumentPressed,
        super(key: key);

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  TopBar(
                    name: widget.name,
                    theme: theme,
                    onDocumentPressed: widget._onDocumentPressed,
                  ),
                  Expanded(
                    child: Chat(
                      messages: widget.messages,
                      user: widget.currentUser,
                      onSendPressed: widget.onSendPressed,
                      theme: DefaultChatTheme(
                        inputTextColor: Colors.black,
                        inputBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        backgroundColor: Colors.white,
                        primaryColor: Theme.of(context).colorScheme.primary,
                        secondaryColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              const Avatar(),
            ],
          ),
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Row(
          children: const [
            SizedBox(width: 25),
            CircleAvatar(
              radius: 50,
            ),
          ],
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.name,
    required this.theme,
    void Function()? onDocumentPressed,
  })  : _onDocumentPressed = onDocumentPressed,
        super(key: key);

  final String name;
  final ThemeData theme;
  final void Function()? _onDocumentPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFFBD70),
            Color(0xFFFF9877),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 48),
          const Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: theme.textTheme.headline2!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
              const SizedBox(height: 5),
            ],
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: _onDocumentPressed,
            icon: Icon(
              Icons.file_open,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
