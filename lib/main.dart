import 'package:flutter/material.dart';
import 'package:projeto_shop/models/auth.dart';
import 'package:projeto_shop/models/cart.dart';
import 'package:projeto_shop/models/order_list.dart';
import 'package:projeto_shop/models/product_list.dart';
import 'package:projeto_shop/pages/auth_page.dart';
import 'package:projeto_shop/pages/cart_page.dart';
import 'package:projeto_shop/pages/orders_page.dart';
import 'package:projeto_shop/pages/product_detail_page.dart';
import 'package:projeto_shop/pages/product_form_page.dart';
import 'package:projeto_shop/pages/product_page.dart';
import 'package:projeto_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.orange),
        ),
        //home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH: (ctx) => const AuthPage(),
          AppRoutes.HOME: (ctx) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
