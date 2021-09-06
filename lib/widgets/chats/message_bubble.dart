import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String userName;
  final String message;
  final String imageUrl;
  final String uploadedImage;

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }

  final bool isMe;
  MessageBubble(this.message, this.uploadedImage, this.isMe, this.imageUrl,
      this.userName);
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
        if (uploadedImage != 'null')
          Container(
            margin: EdgeInsets.all(7),
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            width: 200,
            height: 200,
            child: Image.network(
              uploadedImage,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          )
        else
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
