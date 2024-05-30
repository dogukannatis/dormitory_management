import 'package:dormitory_management/models/message.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserProfileChats extends StatefulWidget {
  const UserProfileChats({Key? key}) : super(key: key);

  @override
  State<UserProfileChats> createState() => _UserProfileChatsState();
}

class _UserProfileChatsState extends State<UserProfileChats> {
  List<String> users = ['Ahmet', 'Mehmet', 'Selim'];
  String? _selectedUser;
  List<Message> messages = [
    Message(id: '1', senderID: '1', receiverID: '2', content: 'Hello there!', createdAt: DateTime.now().subtract(const Duration(minutes: 5))),
    Message(id: '2', senderID: '2', receiverID: '1', content: 'Hi! Whats up?', createdAt: DateTime.now().subtract(const Duration(minutes: 3))),
    Message(id: '3', senderID: '1', receiverID: '2', content: 'I\'m perfect, thanks! What about you?', createdAt: DateTime.now().subtract(const Duration(minutes: 1))),
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _startNewChat(context);
                        },
                        child: const Text('Start New Chat'),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              title: Text(user),
                              onTap: () {
                                _startChatWithUser(user);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _selectedUser != null
                        ? ChatScreen(user: _selectedUser!, messages: messages)
                        : const Center(child: Text('Select a user to start chatting')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(hintText: 'Type a message'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startNewChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('You already have open chats with all users, there is no new users to chat.'),
    ));
  }

  void _startChatWithUser(String user) {
    setState(() {
      _selectedUser = user;
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && _selectedUser != null) {
      setState(() {
        final newMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderID: '1',
          receiverID: '2',
          content: _messageController.text,
          createdAt: DateTime.now(),
        );
        messages.add(newMessage);
        _messageController.clear();
      });
    }
  }
}

class ChatScreen extends StatelessWidget {
  final String user;
  final List<Message> messages;

  const ChatScreen({Key? key, required this.user, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(
            message.senderID == '1' ? 'You' : 'Other User',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(message.content),
          trailing: Text(_formatDateTime(message.createdAt!)),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      final days = difference.inDays;
      if (days == 1) {
        return 'Yesterday';
      } else if (days < 7) {
        return '$days days ago';
      } else {
        final weeks = (days / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      }
    }
  }
}
