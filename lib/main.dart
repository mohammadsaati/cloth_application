import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/home.dart';
import './view/login_screen.dart';
import './view/shopping_cart_screen.dart';
import './view/order_screen.dart';
import './view/splash_screen.dart';
import './provider/product_provider.dart';
import './provider/home_provider.dart';
import './provider/shopping_cart_provider.dart';
import './provider/calculation_provider.dart';
import './provider/vendor_provider.dart';
import './provider/search_provider.dart';
import './provider/order_provider.dart';
import './provider/auth_provider.dart';
import './provider/customer_address_provider.dart';

import './view/order_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider( create: (_) => ProductProvider() ) ,
          ChangeNotifierProvider( create: (_) => HomeProvider() ) ,
          ChangeNotifierProvider(create: (_)  => ShoppingCartProvider()) ,
          ChangeNotifierProvider(create: (_)  => CalculationProvider()) ,
          ChangeNotifierProvider(create: (_)  => VendorProvider()) ,
          ChangeNotifierProvider(create: (_)  => SearchProvider()) ,
          ChangeNotifierProvider(create: (_)  => OrderProvider()) ,
          ChangeNotifierProvider(create: (_)  => CustomerAddressProvider()) ,
          ChangeNotifierProvider(create: (_)  => AuthProvider()) ,
        ] ,
      child: MaterialApp(
        title: 'Mohammad',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.redAccent,
            primarySwatch: Colors.amber,
            fontFamily: "IRANSans"
        ),
        home: const SplashScreen(),

        routes: {
          HomePage.routeName                                  : (ctx)   =>    const HomePage() ,
          ShoppingCartScreen.screenRouteName                  : (ctx)   =>    const ShoppingCartScreen() ,
          OrderScreen.routeName                               : (ctx)   =>    const OrderScreen() ,
          OrderDetailScreen.routeName                         : (ctx)   =>    const OrderDetailScreen() ,
          SplashScreen.routeName                              : (ctx)   =>    const SplashScreen() ,
          LoginScreen.routeName                               : (ctx)   =>    const LoginScreen() ,
        },
      ),
    );
  }
}

