import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart_provider.dart';

class OrderItemClass {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItemClass({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItemClass> _orders = [];
  final String authToken;

  OrdersProvider(this.authToken, this._orders);

  List<OrderItemClass> get orders {
    return [..._orders];
  }

  final timestamp = DateTime.now().toIso8601String();

  Future<void> getOrders() async {
    final url =
        'https://shopping-app-flutter-33531-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(Uri.parse(url));
    final List<OrderItemClass> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    extractedData.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItemClass(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    cartId: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://shopping-app-flutter-33531-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'amount': total,
        'dateTime': DateTime.parse(timestamp),
        'products': cartProducts
            .map((cartProducts) => {
                  'id': cartProducts.cartId,
                  'title': cartProducts.title,
                  'quantity': cartProducts.quantity,
                  'price': cartProducts.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0, //it will add the item to the beginning
      OrderItemClass(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.parse(timestamp),
      ),
    );
    notifyListeners();
  }
}
