import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ProductOverviewScreen extends StatefulWidget {
  static const routeNmae = '/product-detail';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();

}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop")),
      body: Center(child: Text("Text")),
      drawer: AppDrawer(),

    );
  }
}
