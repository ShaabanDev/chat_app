import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/CmDaTL9MJXEsB3Apv61V/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/CmDaTL9MJXEsB3Apv61V/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
