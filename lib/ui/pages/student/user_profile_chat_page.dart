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
  String? _selectedUser;
  List<Message> messages = [
    Message(id: '1', senderID: '1', receiverID: '2', content: 'Hello User A!', createdAt: DateTime.now().subtract(Duration(minutes: 5))),
    Message(id: '2', senderID: '2', receiverID: '1', content: 'Hi! How are you?', createdAt: DateTime.now().subtract(Duration(minutes: 3))),
    Message(id: '3', senderID: '1', receiverID: '2', content: 'I\'m good, thanks! How about you?', createdAt: DateTime.now().subtract(Duration(minutes: 1))),
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Drawer(
              child: Card(
                elevation: 5,
                color: Colors.white,
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
                        child: ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (context, index) => Divider(),
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
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _selectedUser != null
                        ? ChatScreen(user: _selectedUser!, messages: messages)
                        : Center(child: Text('Select a user to start chatting')),
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
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  void _startNewChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Start New Chat feature is not implemented yet!'),
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
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(
            message.senderID == '1' ? 'You' : 'Other User',
            style: TextStyle(fontWeight: FontWeight.bold),
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








/*

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
  String? _selectedUser;
  List<Message> messages = [
    Message(id: '1', senderID: '1', receiverID: '2', content: 'Hello User A!', createdAt: DateTime.now().subtract(Duration(minutes: 5))),
    Message(id: '2', senderID: '2', receiverID: '1', content: 'Hi! How are you?', createdAt: DateTime.now().subtract(Duration(minutes: 3))),
    Message(id: '3', senderID: '1', receiverID: '2', content: 'I\'m good, thanks! How about you?', createdAt: DateTime.now().subtract(Duration(minutes: 1))),
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
                color: Colors.white,
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
                        child: ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (context, index) => Divider(),
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

            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _selectedUser != null
                        ? ChatScreen(user: _selectedUser!, messages: messages)
                        : Center(child: Text('Select a user to start chatting')),
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Start New Chat feature is not implemented yet!'),
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
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(
            message.senderID == '1' ? 'You' : 'Other User',
            style: TextStyle(fontWeight: FontWeight.bold),
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

*/