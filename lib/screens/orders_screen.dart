import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OrdersScreen")),
      body: Center(child: Text("OrdersScreen")),
      drawer: AppDrawer(),
    );
  }
}
