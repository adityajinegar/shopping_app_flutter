import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/pages/auth_page.dart';
import 'pages/cart_page.dart';
import 'pages/edit_product_page.dart';
import 'pages/orders_page.dart';
import 'pages/user_product_page.dart';
import 'providers/orders.dart';

import 'pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';
import 'providers/cart_provider.dart';
import 'providers/products_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //If using the provider for the first time, use the create syntax, if reusing it then use the .value syntax
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
              .copyWith(secondary: Colors.tealAccent),
          fontFamily: 'Lato',
        ),
        home: AuthPage(),
        routes: {
          ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
          CartPage.routeName: (context) => const CartPage(),
          OrdersPage.routeName: (context) => const OrdersPage(),
          UserProductPage.routeName: (context) => const UserProductPage(),
          EditProductPage.routeName: (context) => const EditProductPage(),
        },
      ),
    );
  }
}
