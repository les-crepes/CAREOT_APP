import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdg_app/model/conversation_tile_data.dart';

import '../widgets/badge.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DiscussionList(
      conversationsTileData: [
        ConversationTileData(
          title: "test",
          lastMessage: DateTime.now(),
          unreadCount: 2,
        ),
      ],
    );
  }
}

class DiscussionList extends StatelessWidget {
  final List<ConversationTileData> _conversationsTileData;

  const DiscussionList({
    required List<ConversationTileData> conversationsTileData,
    Key? key,
  })  : _conversationsTileData = conversationsTileData,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('h:m:s d/m/y');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Discussions',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final conv = _conversationsTileData[index];
              return _ConversationTile(
                conversationImage: conv.avatar ??
                    const AssetImage('assets/images/default_user_pic.png'),
                conversationTitle: conv.title ?? 'Conversation ${index + 1}',
                conversationSubtitle: conv.lastMessage != null
                    ? format.format(conv.lastMessage!)
                    : 'No messages yet',
                conversationUnreadCount:
                    _conversationsTileData[index].unreadCount ?? 0,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black38,
                thickness: 1,
              );
            },
            itemCount: _conversationsTileData.length,
          ),
        ),
      ],
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final String _conversationTitle;
  final String _conversationSubtitle;
  final int _conversationUnreadCount;
  final ImageProvider _conversationImage;
  final void Function()? _onTap;

  const _ConversationTile({
    Key? key,
    required String conversationTitle,
    required String conversationSubtitle,
    required int conversationUnreadCount,
    required ImageProvider conversationImage,
    void Function()? onTap,
  })  : _conversationTitle = conversationTitle,
        _conversationSubtitle = conversationSubtitle,
        _conversationUnreadCount = conversationUnreadCount,
        _conversationImage = conversationImage,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: _onTap,
        leading: CircleAvatar(
          backgroundImage: _conversationImage,
        ),
        trailing: _conversationUnreadCount == 0
            ? const SizedBox()
            : Badge(_conversationUnreadCount),
        title: Text(_conversationTitle),
        subtitle: Text(_conversationSubtitle),
      ),
    );
  }
}
