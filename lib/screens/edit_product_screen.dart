import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EditProductScreen")),
      body: Center(child: Text('EditProductScreen')),
    );;
  }
}

