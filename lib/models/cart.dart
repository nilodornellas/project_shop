import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projeto_shop/models/cart_item.dart';
import 'package:projeto_shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCout {
    return _items.length;
  }

  double get totalAmout {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble.toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
        id: existingItem.id,
        productId: existingItem.productId,
        name: existingItem.name,
        quantity: existingItem.quantity - 1,
        price: existingItem.price,
      ),
    );
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
