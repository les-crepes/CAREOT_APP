import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DiscussionList();
  }
}

class DiscussionList extends StatelessWidget {
  const DiscussionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('h:m:s d/m/y');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
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
              return _ConversationTile(
                conversationImage:
                    const AssetImage('assets/images/default_user_pic.png'),
                conversationTitle: 'Conversation ${index + 1}',
                conversationSubtitle: format.format(DateTime.now()),
                conversationUnreadCount: 10,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black38,
                thickness: 1,
              );
            },
            itemCount: 10,
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

  const _ConversationTile({
    Key? key,
    required String conversationTitle,
    required String conversationSubtitle,
    required int conversationUnreadCount,
    required ImageProvider conversationImage,
  })  : _conversationTitle = conversationTitle,
        _conversationSubtitle = conversationSubtitle,
        _conversationUnreadCount = conversationUnreadCount,
        _conversationImage = conversationImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: _conversationImage,
        ),
        trailing: _conversationUnreadCount == 0
            ? const SizedBox()
            : _Badge(_conversationUnreadCount),
        title: Text(_conversationTitle),
        subtitle: Text(_conversationSubtitle),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int _count;
  const _Badge(
    int count, {
    Key? key,
  })  : _count = count,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          _count.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
