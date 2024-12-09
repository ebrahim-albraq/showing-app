import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UserProductsScreen")),
      body: Center(child: Text('UserProductsScreen')),
      drawer: AppDrawer(),

    );
  }
}
