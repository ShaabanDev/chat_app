import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) trysubmit;
  AuthForm(this.trysubmit, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _formKey = GlobalKey<FormState>();
  var _userName = '';
  var _userEmail = '';
  var _userPassowrd = '';
  var _login = true;
  void _trySubmit() {
    final _validstate = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_validstate) {
      _formKey.currentState!.save();
      widget.trysubmit(
          _userEmail.trim(), _userPassowrd, _userName.trim(), _login, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('Email'),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Invalid Email!";
                    }
                    return null;
                  },
                ),
                if (!_login)
                  TextFormField(
                    key: ValueKey('user name'),
                    onSaved: (value) {
                      _userName = value!;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'user name'),
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 5) {
                        return "User name must be 6 characters at least!";
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('Passowrd'),
                  onSaved: (value) {
                    _userPassowrd = value!;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Passowrd'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 7) {
                      return "User name must be 8 characters at least!!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_login ? 'Login' : 'SignUp'),
                  ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _login = !_login;
                    });
                  },
                  child: Text(_login
                      ? 'Create new account'
                      : 'I already have an account!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
