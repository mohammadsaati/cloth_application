import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/home.dart';
import './provider/product_provider.dart';
import './provider/home_provider.dart';

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
          HomePage.routeName          :     (ctx)   =>    const HomePage() ,
        },
      ),
    );
  }
}

