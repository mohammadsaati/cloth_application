import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app.dart';
import '../widgets/app_bar_cart_item.dart';
import '../provider/shopping_cart_provider.dart';
import '../models/shopping_cart.dart';
import '../widgets/shopping_cart_item_widget.dart';
import '../models/calculation.dart';
import '../provider/calculation_provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  static const String screenRouteName = "shopping_cart_screen";

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool _isLoading = true;
  bool _isInit = true;
  late ShoppingCart cart;
  late Calculation calculation;


  @override
  void didChangeDependencies() async
  {
    if(_isInit)
    {
        final loadedCart = await Provider.of<ShoppingCartProvider>(context).getShoppingCart();
       final loadedCalc = await Provider.of<CalculationProvider>(context , listen: false).getCalculation();



        setState(() {
          cart = loadedCart;
          calculation = loadedCalc;
          _isLoading = false;
        });
    }

    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: const [
          AppBarCartIcon()
        ],
      ),
      body: _isLoading ?
      const Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

               SizedBox(
                width: double.infinity,
                height: 70,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent ,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                        "Total Price :"+ calculation.price.toString() ,
                        style:const TextStyle(
                          fontWeight: FontWeight.bold ,
                          color: Colors.white ,
                          fontSize: 20
                        ),
                    ),
                  ),
                ),
              ) ,

              const SizedBox(height: 10,) ,

              Column(
                children: cart.items.map((item) {
                  return ShoppingCartItemWidget(cartItem: item,);
                }).toList(),
              )

            ],
          ),
        ),
      ),
    );
  }
}
