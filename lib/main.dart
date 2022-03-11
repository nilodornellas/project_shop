import 'package:flutter/material.dart';
import 'package:projeto_shop/models/auth.dart';
import 'package:projeto_shop/models/cart.dart';
import 'package:projeto_shop/models/order_list.dart';
import 'package:projeto_shop/models/product_list.dart';
import 'package:projeto_shop/pages/auth_or_home_page.dart';
import 'package:projeto_shop/pages/cart_page.dart';
import 'package:projeto_shop/pages/orders_page.dart';
import 'package:projeto_shop/pages/product_detail_page.dart';
import 'package:projeto_shop/pages/product_form_page.dart';
import 'package:projeto_shop/pages/product_page.dart';
import 'package:projeto_shop/utils/app_routes.dart';
import 'package:projeto_shop/utils/custom_route.dart';
import 'package:provider/provider.dart';

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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              previous?.items ?? [],
              auth.userid ?? '',
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.orange),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
              TargetPlatform.android: CustomPageTransitionsBuilder(),
            },
          ),
        ),
        //home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
