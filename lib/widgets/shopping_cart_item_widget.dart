import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shopping_cart_item.dart';
import '../view/product/product_details.dart';
import '../provider/shopping_cart_provider.dart';

class ShoppingCartItemWidget extends StatefulWidget {

  final ShoppingCartItem cartItem;
  const ShoppingCartItemWidget({Key? key , required this.cartItem}) : super(key: key);

  @override
  _ShoppingCartItemWidgetState createState() => _ShoppingCartItemWidgetState();
}

class _ShoppingCartItemWidgetState extends State<ShoppingCartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0) ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetails(productSlug: widget.cartItem.slug))
          );
        },
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0) ,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage( widget.cartItem.image ),
                  backgroundColor: Colors.amber,
                ) ,
              ) ,

              // const SizedBox(width: 5,) ,

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 0) ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.name ,
                      style: const TextStyle(
                          fontSize: 15 ,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 2,

                    ) ,

                    const SizedBox(height: 2,) ,

                    Text(
                      "price : "+widget.cartItem.price.toString() ,
                      style: const TextStyle(
                          fontSize: 10 ,
                          fontWeight: FontWeight.bold ,
                          color: Colors.grey
                      ),

                    ) ,
                    const SizedBox(height: 2,) ,

                    Text(
                      "total price : "+widget.cartItem.totalPrice.toString() ,
                      style: const TextStyle(
                          fontSize: 10 ,
                          fontWeight: FontWeight.bold ,
                          color: Colors.grey
                      ),
                    ) ,

                    const SizedBox(height: 2,) ,

                    Text(
                      "size : "+widget.cartItem.size.value ,
                      style: const TextStyle(
                          fontSize: 10 ,
                          fontWeight: FontWeight.bold ,
                          color: Colors.grey
                      ),
                    ) ,

                    // const SizedBox(height: 2,) ,

                    Container(
                      width: 60,
                      height: 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0) ,
                          color: HexColor.fromHex( widget.cartItem.color.code )
                      ),
                    ) ,

                  ],
                ),
              ) ,


              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          widget.cartItem.count++;
                        });
                        await Provider.of<ShoppingCartProvider>(context , listen: false).addItemTOShoppingCart(widget.cartItem.id, widget.cartItem.count);
                      },
                      child:  Card(
                        elevation: 8,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5) ,
                            color: Colors.green ,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "+" ,
                            style: TextStyle(
                                fontSize: 15 ,
                                fontWeight: FontWeight.bold ,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ) ,
                    ) ,

                    Text(
                      widget.cartItem.count.toString() ,
                      style: const TextStyle(
                          fontSize: 15 ,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ) ,

                    InkWell(
                      onTap: () async{

                        setState(() {
                          widget.cartItem.count--;
                        });

                        await Provider.of<ShoppingCartProvider>(context , listen: false).addItemTOShoppingCart(widget.cartItem.id, widget.cartItem.count);

                      },
                      child:  Card(
                        elevation: 8,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5) ,
                              color: Colors.red
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "-" ,
                            style: TextStyle(
                                fontSize: 15 ,
                                fontWeight: FontWeight.bold ,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ) ,
                    ) ,


                  ],
                ),
              )


            ],

          ),
        ),
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
