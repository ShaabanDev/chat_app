import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('sendTime', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapShot) {
          if (chatSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chat = chatSnapShot.data!.docs;
          final currentUserId = FirebaseAuth.instance.currentUser!.uid;
          return ListView.builder(
            reverse: true,
            itemCount: chat.length,
            itemBuilder: (ctx, index) => MessageBubble(
                chat[index]['text'],
                chat[index]['userId'] == currentUserId,
                chat[index]['userimage'],
                chat[index]['userName']),
          );
        });
  }
}
