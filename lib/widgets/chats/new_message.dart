import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage;
  File? sendImageFile;
  String uploadedImage = '';
  var enteredMessageContoller = TextEditingController();
  bool imageOrNot = false;
  Future<void> _sendMessage() async {
    enteredMessageContoller.clear();
    // FocusScope.of(context).unfocus();
    final chatDoc = FirebaseFirestore.instance.collection('chat');
    final currentUser = FirebaseAuth.instance.currentUser;
    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    await chatDoc.add({
      'text': imageOrNot ? 'default' : enteredMessage,
      'image': imageOrNot ? uploadedImage : 'null',
      'sendTime': Timestamp.now(),
      'userId': currentUser.uid,
      'userName': userDocs.get('username'),
      'userImage': userDocs.get('userimage'),
    }).then((x) {
      setState(() {
        enteredMessage = '';
        imageOrNot = false;
      });
    });
  }

  void sendImage() async {
    FocusScope.of(context).unfocus();

    ImagePicker img = ImagePicker();
    final imageFile =
        await img.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (imageFile == null) {
      return;
    }

    sendImageFile = File(imageFile.path);

    final imageRef = FirebaseStorage.instance
        .ref()
        .child('chatImages')
        .child(DateTime.now().toString() + 'jpg');
    await imageRef.putFile(sendImageFile!).whenComplete(() async {
      uploadedImage = await imageRef.getDownloadURL();
      setState(() {
        imageOrNot = true;
      });
    });
    _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: sendImage,
            icon: Icon(Icons.photo),
            color: Theme.of(context).primaryColor,
          ),
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
            onPressed: enteredMessage == "" ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
