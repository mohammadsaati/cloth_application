import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/home.dart';
import './view/shopping_cart_screen.dart';
import './provider/product_provider.dart';
import './provider/home_provider.dart';
import './provider/shopping_cart_provider.dart';
import './provider/calculation_provider.dart';
import './provider/vendor_provider.dart';
import './provider/search_provider.dart';

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
        ] ,
      child: MaterialApp(
        title: 'Mohammad',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.redAccent,
            primarySwatch: Colors.amber,
            fontFamily: "IRANSans"
        ),
        home: const HomePage(),

        routes: {
          HomePage.routeName                                  : (ctx)   =>    const HomePage() ,
          ShoppingCartScreen.screenRouteName                  : (ctx)   =>    const ShoppingCartScreen() ,
        },
      ),
    );
  }
}

