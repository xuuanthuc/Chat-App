import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String textChat;
  final String username;
  final String userImage;

  MessageBubble(this.textChat, this.username, this._isMe, this.userImage,
      {this.key});

  bool _isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!_isMe)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: CircleAvatar(
                maxRadius: 15,
                backgroundImage: NetworkImage(userImage),
              ),
            ),
            flex: 1,
          ),
          Flexible(
            flex: 4,
            child: Column(
              children: [
                Container(
                  child: Text(
                    username,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft:
                          _isMe ? Radius.circular(15) : Radius.circular(0),
                      bottomRight:
                          _isMe ? Radius.circular(0) : Radius.circular(15),
                    ),
                    color: _isMe ? Colors.grey[300] : Colors.pink[300],
                  ),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: Text(
                    textChat,
                    style: TextStyle(
                        fontSize: 16,
                        color: _isMe ? Colors.black : Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Flexible(flex: 1, child: SizedBox())
        ],
      ),
    );
  }
}
