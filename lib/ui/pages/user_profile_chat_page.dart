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
  List<String> users = ['User A', 'User B', 'User C'];
  Message? _selectedMessage;
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];

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
                        child: Text('Start New Chat'),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(user),
                                  onTap: () {
                                    _startChatWithUser(context, user);
                                  },
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _selectedMessage != null ? ChatScreen(message: _selectedMessage!) : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(hintText: 'Type a message'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _sendMessage();
                          },
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Start New Chat feature is not implemented yet!'),
    ));
  }

  void _startChatWithUser(BuildContext context, String user) {
    setState(() {
      _selectedMessage = Message(
        id: '1',
        senderID: '1',
        receiverID: '2',
        content: 'Hi $user, how are you?',
        createdAt: DateTime.now(),
      );
    });
  }

  void _sendMessage() {
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

class ChatScreen extends StatelessWidget {
  final Message message;

  const ChatScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                message.senderID == '1' ? 'You' : 'Other User',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message.content),
              trailing: Text(_formatDateTime(message.createdAt!)),
            ),
            Divider(),
          ],
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
