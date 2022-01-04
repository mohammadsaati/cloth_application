import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app.dart';
import '../widgets/app_bar_cart_item.dart';
import '../provider/shopping_cart_provider.dart';
import '../models/shopping_cart.dart';
import '../widgets/shopping_cart_item_widget.dart';
import '../models/calculation.dart';
import '../provider/calculation_provider.dart';
import '../provider/order_provider.dart';
import '../provider/customer_address_provider.dart';
import '../view/home.dart';

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

               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,

                 children: [

                   SizedBox(
                     width: MediaQuery.of(context).size.width * 0.73,
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

                   SizedBox(
                     width: MediaQuery.of(context).size.width * 0.20,
                     height: 60,
                     child: ElevatedButton(
                       onPressed: () async {
                            final addressProvider = Provider.of<CustomerAddressProvider>(context , listen: false);
                            late int addressId;
                            await addressProvider.getAddress();

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Select Address" ,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                    ),
                                    content: Container(
                                      width: 300,
                                      height: 200,
                                      child: ListView.builder(

                                          itemCount: addressProvider.addresses.length,
                                          itemBuilder: (context , index) {
                                            return Padding(
                                                padding: const EdgeInsets.all(10) ,
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                        addressId = addressProvider.addresses[index].id;
                                                    });

                                                    await Provider.of<OrderProvider>(context , listen: false).submitOrder(addressId.toString());

                                                    Navigator.pop(context);
                                                    Navigator.pushNamed(context, HomePage.routeName);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content:  Text("Order submited")
                                                        )
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 10,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10) ,
                                                      child: Text(
                                                        addressProvider.addresses[index].fullAddress ,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            );
                                          },
                                      ) ,
                                    ),
                                  );
                                }
                            );
                       },
                       child: const Text(
                           "Order" ,
                         style: TextStyle(
                           fontWeight: FontWeight.bold ,
                           fontSize: 18
                         ),
                       ),
                     )
                   )

                 ],
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
