import 'package:chat_app/widgets/chats/messages.dart';
import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text("Logout"),
                ]),
                value: "LOGOUT",
              )
            ],
            onSelected: (value) {
              if (value == 'LOGOUT') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }
}
