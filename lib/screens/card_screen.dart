import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  static const routeName = '/card';

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("CartScreen")),
      body: Center(child: Text("CartScreen")),
    );
  }
}

