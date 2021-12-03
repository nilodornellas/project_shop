import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projeto_shop/models/cart.dart';
import 'package:projeto_shop/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmout,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
