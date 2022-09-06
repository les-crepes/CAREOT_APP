import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';
import 'package:provider/provider.dart';

import '../provider/chat_provider.dart';
import '../router/router.gr.dart';
import '../widgets/custom_list.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomList(
      title: 'Discussions',
      conversationsTileData: context
          .watch<ChatProvider>()
          .getLastMessageOfEachUser()
          .map((e) => CustomListTileData(
                title: '${e.key.firstName} ${e.key.lastName}',
                subtitle: e.value.content,
                date: e.value.time,
                avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (e.key.photoUrl != null
                                  ? NetworkImage(e.key.photoUrl!)
                                  : const AssetImage(
                                      "assets/images/default_user_pic.png"))
                              as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                onTap: () {
                  AutoRouter.of(context)
                      .push(ChatScreenRoute(otherUser: e.key));
                },
              ))
          .toList(),
    );
  }
}
