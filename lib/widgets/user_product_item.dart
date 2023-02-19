import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/edit_product_page.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
  });
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductPage.routeName,
                  arguments: id,
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.teal,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                        content: Text(
                      'Deleting Failed!',
                      textAlign: TextAlign.center,
                    )),
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
