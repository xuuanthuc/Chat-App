import 'dart:io';

import 'package:chat_app/screens/auth_screen/auth_widget/auth_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    bool login,
    File image,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (login) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'image-url': url,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      var message = 'An error occurred, please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Theme.of(ctx).primaryColor,
      body: AuthWidget(_submitAuthForm, _isLoading),
    );
  }
}
