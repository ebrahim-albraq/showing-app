import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/user_products_screen.dart';

import '../providers/auth.dart';
import '../providers/orders.dart';
import '../providers/card.dart';
import './screens/card_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              home: auth.isAuth? ProductOverviewScreen() : FutureBuilder(
                future: auth.tryAutoLogin(),
                initialData: Auth,
                builder: (BuildContext context, authSnapshot) =>
                authSnapshot.connectionState == ConnectionState.waiting
                    ?SplashScreen()
                    :AuthScreen(),
              ),
              routes: {
              ProductDetailScreen.routeName: (_) => ProductOverviewScreen(),
              CardScreen.routeName: (_) => CardScreen(),
              OrdersScreen.routeName: (_) => OrdersScreen(),
              UserProductsScreen.routeName: (_) => UserProductsScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
            },
            ),
      ),
    );
  }
}
