import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/chat_provider.dart';
import '../widgets/custom_list.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(GetIt.I.get<AuthProvider>()),
      builder: (context, child) {
        return FutureBuilder(
          future: context.read<ChatProvider>().fetchAllMessages(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.done
                  ? CustomList(
                      title: 'Discussions',
                      conversationsTileData: [
                        CustomListTileData(
                          title: "test",
                          date: DateTime.now(),
                          badgeCount: 2,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [CircularProgressIndicator()]),
        );
      },
    );
  }
}
