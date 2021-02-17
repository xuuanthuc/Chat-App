import 'package:chat_app/screens/auth_screen/auth_screen.dart';
import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => FocusScope.of(context).requestFocus(new FocusNode()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Colors.pinkAccent,
          primaryColor: Colors.pinkAccent
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot){
            if(userSnapshot.hasData){
              return ChatScreen();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
