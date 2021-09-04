import 'dart:math';

import 'package:chat_app/widgets/chats/messages.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String userName;
  final String message;
  final String imageUrl;

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }

  final bool isMe;
  MessageBubble(this.message, this.isMe, this.imageUrl, this.userName);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(imageUrl),
          ),
        //   userName.length.toDouble() * 15

        Container(
          width: max(calcTextSize(message, TextStyle(fontSize: 17)).width,
              userName.length.toDouble() * 15),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          child: Column(children: [
            Text(userName),
            Text(
              message,
              style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline1!.color),
            )
          ]),
        ),
      ],
    );
  }
}
