import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';
class AppDrawer extends StatefulWidget {



  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  Widget buildListTile(String title,IconData icon, selectedFilters ){

    return ListTile(
      leading: Icon(icon,size: 26),
      title: Text(
        title,
        style:const TextStyle(
          fontSize: 20,
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
      onTap:   selectedFilters,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.all(30),
            alignment: Alignment.centerLeft,
            color: Theme
                .of(context)
                .primaryColorDark,
            child:  ListView(
                children: [
                  UserAccountsDrawerHeader(accountName: Text('Ibrahim AL-buraq'),
                    accountEmail:Text('Ibrahim@AL-buraq.com'),
                    decoration: BoxDecoration(
                    ),
                    currentAccountPicture:CircleAvatar(
                      backgroundColor: Colors.grey,
                      child:Icon(Icons.person,size: 50,color: Colors.yellow,),
                    ),

                  ),
                ]
            ),
          ),
          SizedBox(height: 20),

          buildListTile("shop",Icons.shopify,(){Navigator.of(context).pushReplacementNamed('/');}),
          buildListTile("orders",Icons.payment,(){Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);}),
          buildListTile("Mnage Product",Icons.edit,(){Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);}),
          buildListTile("Logout",Icons.settings,(){Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
          Provider.of<Auth>(context,listen: false).logout();
          }),




          // buildListTile("Meal",Icons.restaurant,(){Navigator.of(context).pushNamed('/');}),
          // buildListTile("Filters",Icons.settings,(){Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);}),

        ],
      ),
    );
  }
}
