import 'package:chat_app/screens/chat_screen/chat_widget/chat_widget.dart';
import 'package:chat_app/screens/chat_screen/chat_widget/sent_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('HappyChat'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              icon: Icon(Icons.menu, color: Colors.white,),
              onChanged: (itemIdentifier){
                if(itemIdentifier == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
              },
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            SentChat(),
          ],
        ),
      ),
    );
  }
}
