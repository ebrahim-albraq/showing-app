
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient:
            LinearGradient(colors: [
              Color.fromARGB(215, 117, 255, 1).withOpacity(0.5),
              Color.fromARGB(255, 188, 117, 1).withOpacity(0.9),
            ], begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 94),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Text(
                        "My Shop ",
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .accentTextTheme
                                .headline6
                                ?.color,
                            fontSize: 50,
                            fontFamily: 'Anton'),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1, child: AuthCard()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {

  @override
  State<AuthCard> createState() => _AuthCardState();
}

enum AuthMode { Login, SingnUp}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map <String, String>  _authData =
  {
    'email': '',
    'password': '',
  };

  var _isLoading = true;
  final _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.15),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email']!, _authData['password']!);
      }
      else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email']!, _authData['password']!);
      }
    }on HttpException catch(error){
      var errorMessage = 'Authentication failed';
      if(error.toString().contains('EMAIL_EXISTS')) {
        var errorMessage = 'This email address is already in use';
      }
      else if(error.toString().contains('INVALID_EMAIL')) {
        var errorMessage = 'This  is not a valid email address';
      }
      else if(error.toString().contains('WEAK_PASSWORD')) {
        var errorMessage = 'This password is too weak';
      }
      else if(error.toString().contains('EMAIL_NOT_FOUND')) {
        var errorMessage = 'Could not find a user with that email';
      }
      else if(error.toString().contains('INVALID_PASSWORD')) {
        var errorMessage = 'Invalid Password';
      }
    }catch(error){
    const errorMessage = 'Could not authenticate you. please try again later ';
    _showErrorDialog(errorMessage);
    }
    setState(() {
    _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(context: context, builder: (ctx)=> AlertDialog(
      title: Text('An Error Occcurred!'),
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: ()=> Navigator.of(ctx).pop(),
            child: const Text('okay!')
        ),
    ]
    )
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SingnUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;

    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20,
        ),
      ),
      elevation: 8.0,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.SingnUp ? 380 : 280,
        constraints: BoxConstraints(
            minHeight: _authMode == AuthMode.SingnUp ? 320 : 260),
        width: deviceSize.width * 0.75,

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['email'] = val!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['password'] = val!;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SingnUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SingnUp ? 120 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,

                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.SingnUp,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password'),
                          validator: _authMode == AuthMode.SingnUp ? (val) {
                          if (val != _passwordController.text) {
                            return 'Password do not match!';
                          }
                          return null;
                        } : null,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                if(_isLoading) CircularProgressIndicator(),
                ElevatedButton(
                  child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    primary: Theme
                        .of(context)
                        .primaryColor,
                    onPrimary: Theme
                        .of(context)
                        .primaryTextTheme
                        .headline6!
                        .color,
                  ),
                ),
                TextButton(
                  child: Text('${_authMode == AuthMode.Login
                      ? 'SIGNUP'
                      : 'LOGIN'}INSTEAD'),
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
