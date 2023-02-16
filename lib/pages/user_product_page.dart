import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/pages/edit_product_page.dart';
import 'package:shopping_app_flutter/widgets/app_drawer.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductPage extends StatelessWidget {
  const UserProductPage({super.key});
  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                title: productsData.items[index].title,
                imageUrl: productsData.items[index].imageUrl,
              ),
              const Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
