import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SentChat extends StatefulWidget {
  @override
  _SentChatState createState() => _SentChatState();
}

class _SentChatState extends State<SentChat> {
  final _controller = new TextEditingController();
  var _enterMess = '';
  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user  = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enterMess,
      'createAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image-url'],
    },);
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(15),
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _enterMess = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.pinkAccent
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white,),
              onPressed: _enterMess.trim().isEmpty ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
