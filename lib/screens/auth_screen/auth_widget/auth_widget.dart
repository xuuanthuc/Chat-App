import 'dart:io';

import 'package:chat_app/screens/chat_screen/pick_image_widget/pick_image.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  AuthWidget(this.submitFn, this.isLoading);

  bool isLoading;
  final Function(
    String email,
    String usesrname,
    String password,
    bool isLogin,
    File image,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isEmail = '';
  var _isUsername = '';
  var _isPassword = '';
  File _userImageFile;

  void _pickImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an Image', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.white38,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
    }
    widget.submitFn(
      _isEmail.trim(),
      _isUsername.trim(),
      _isPassword.trim(),
      _isLogin,
      _userImageFile,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) PickImage(_pickImage),
                    TextFormField(
                      key: ValueKey('emailKey'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Enter Email'),
                      onSaved: (value) {
                        _isEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('usernameKey'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Username must be at least 7 character long.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _isUsername = value;
                        },
                        decoration:
                            InputDecoration(labelText: 'Enter Username'),
                      ),
                    TextFormField(
                      key: ValueKey('passwordkey'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 character long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _isPassword = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Enter Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // if(widget.isLoading)
                    //   CircularProgressIndicator(),
                    // if(!widget.isLoading)
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: _trySubmit,
                        child: Text(
                          _isLogin ? 'Login' : 'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // if(!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                        style: TextStyle(color: Colors.pink),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
