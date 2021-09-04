import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage = '';
  var enteredMessageContoller = TextEditingController();
  void _sendMessage() async {
    enteredMessageContoller.clear();
    // FocusScope.of(context).unfocus();
    final chatDoc = FirebaseFirestore.instance.collection('chat');
    final currentUser = FirebaseAuth.instance.currentUser;
    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    await chatDoc.add({
      'text': enteredMessage,
      'sendTime': Timestamp.now(),
      'userId': currentUser.uid,
      'userName': userDocs.get('username'),
      'userImage': userDocs.get('userimage'),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              labelText: 'Send a message.',
            ),
            onChanged: (value) {
              setState(() {
                enteredMessage = value;
              });
            },
            controller: enteredMessageContoller,
          )),
          IconButton(
            onPressed: enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
