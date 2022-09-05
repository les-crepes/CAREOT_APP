import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/chat_provider.dart';
import '../router/router.gr.dart';
import '../widgets/custom_list.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ChatProvider>().fetchAllMessages(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? CustomList(
                  title: 'Discussions',
                  conversationsTileData: context
                      .watch<ChatProvider>()
                      .getLastMessageOfEachUser()
                      .map((e) => CustomListTileData(
                            title: '${e.key.firstName} ${e.key.lastName}',
                            subtitle: e.value.content,
                            date: e.value.time,
                            onTap: () {
                              AutoRouter.of(context)
                                  .push(ChatScreenRoute(otherUser: e.key));
                            },
                          ))
                      .toList(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()]),
    );
  }
}
