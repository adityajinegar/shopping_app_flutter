import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers/auth_provider.dart';
import 'pages/auth_page.dart';
import 'pages/cart_page.dart';
import 'pages/edit_product_page.dart';
import 'pages/orders_page.dart';
import 'pages/user_product_page.dart';
import 'providers/orders_provider.dart';

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
        ChangeNotifierProvider.value(value: AuthProvider()),
        // proxy provider depends on the previous provider. So, in this case whenever the AuthProvider will change, proxy provider will change too.

        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          //If using the provider for the first time, use the create syntax, if reusing it then use the .value syntax
          update: (context, auth, previousProducts) => ProductsProvider(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
            auth.userId,
          ),
          create: (context) => ProductsProvider(
              Provider.of<AuthProvider>(context, listen: false).token, [], ''),
        ),

        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          update: (context, auth, previousOrders) => OrdersProvider(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
          create: (context) => OrdersProvider(
              Provider.of<AuthProvider>(context, listen: false).token, []),
        ),

        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Shop',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
                .copyWith(secondary: Colors.tealAccent),
            fontFamily: 'Lato',
          ),
          home: auth.token != '' ? ProductsOverviewPage() : AuthPage(),
          routes: {
            ProductDetailsPage.routeName: (context) =>
                const ProductDetailsPage(),
            CartPage.routeName: (context) => const CartPage(),
            OrdersPage.routeName: (context) => const OrdersPage(),
            UserProductPage.routeName: (context) => const UserProductPage(),
            EditProductPage.routeName: (context) => const EditProductPage(),
          },
        ),
      ),
    );
  }
}
