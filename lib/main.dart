import 'package:Yummy/providers/Cart.dart';
import 'package:Yummy/providers/Orders.dart';
import 'package:Yummy/screens/CartScreen.dart';
import 'package:Yummy/screens/EditProductScreen.dart';
import 'package:Yummy/screens/OrdersScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/ProductsOverviewScreen.dart';
import 'screens/ProductDetailScreen.dart';
import './screens/UserProductsScreen.dart';

import 'providers/Products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          }),
    );
  }
}
