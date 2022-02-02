import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_shop/models/cart.dart';
import 'package:projeto_shop/models/cart_item.dart';
import 'package:projeto_shop/models/order.dart';
import 'package:projeto_shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();
    final response =
        await http.get(Uri.parse('${Constants.ORDER_BASE_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      _items.add(
        Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  productId: item['productId'],
                  name: item['name'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
          date: DateTime.parse(orderData['date']),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode(
        {
          "total": cart.totalAmout,
          "date": date.toIso8601String(),
          "products": cart.items.values
              .map((cartItem) => {
                    "id": cartItem.id,
                    "productId": cartItem.productId,
                    "name": cartItem.name,
                    "quantity": cartItem.quantity,
                    "price": cartItem.price,
                  })
              .toList(),
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmout,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
