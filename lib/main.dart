import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //If using the provider for the first time, use the create syntax, if reusing it then use the .value syntax
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
              .copyWith(secondary: Colors.tealAccent),
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewPage(),
        routes: {
          ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
        },
      ),
    );
  }
}