import 'package:flutter/material.dart';

import '../view/shopping_cart_screen.dart';

class AppBarCartIcon extends StatefulWidget {
  const AppBarCartIcon({Key? key}) : super(key: key);

  @override
  _AppBarCartIconState createState() => _AppBarCartIconState();
}

class _AppBarCartIconState extends State<AppBarCartIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
            onPressed: () {
                Navigator.pushNamed(context, ShoppingCartScreen.screenRouteName);
            },
            icon: const Icon(
              Icons.shopping_cart ,
              color: Colors.white,
              size: 24,
            )
        ) ,
        Positioned(
            right: 8,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0) ,
                  color: Colors.red
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: const Text(
                "10" ,
                style: TextStyle(
                  color: Colors.white ,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            )
        ) ,
      ],
    );
  }
}
