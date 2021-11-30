import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/shopping_cart_provider.dart';

class AddToCartButton extends StatefulWidget {

  final int stock;
  final int productId;

  const AddToCartButton({Key? key , required this.productId , required this.stock}) : super(key: key);

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {

  int count = 0;
  @override
  Widget build(BuildContext context) {

    final shoppingCart = Provider.of<ShoppingCartProvider>(context);


    bool _isLoading = false;


    /*if(count == 0)
    {
      return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child:  TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = 0;
                  count++;
                });

                print(count);
              },
              child: Text("+")
          ) ,
      );
    }*/

    return count == 0 ?
    Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child:  TextButton(
          onPressed: () async {
            setState(() {
              _isLoading = true;
              count++;
            });

            await shoppingCart.addItemTOShoppingCart(widget.productId, count);

            setState(() {
              _isLoading = false;
            });
          },
          child: Text("+")
      ) ,
    )
        :Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
          count > 1 ?

          TextButton(
              onPressed: () async {

                setState(() {
                  _isLoading = true;
                  count--;
                });
                print(count);
               await shoppingCart.addItemTOShoppingCart(widget.productId, count);

               setState(() {
                  _isLoading = false;
               });

              },
              child: IconButton(
                onPressed: () {
                  setState(() {
                    count--;
                  });
                },
                icon: const Icon(
                    Icons.minimize_sharp ,
                    color: Colors.red,
                ),
                
              ) ,
          ) :
          IconButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                  count--;
                });
                print(count);
                await shoppingCart.addItemTOShoppingCart(widget.productId, count);

                setState(() {
                  _isLoading = false;
                });

              },
              icon: const Icon(Icons.delete) ,
              color: Colors.red,

          ) ,

        const SizedBox(width: 5,) ,

        _isLoading ? const Center( child: CircularProgressIndicator(), ) :Text(
          count.toString() ,
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),
        ) ,


        const SizedBox(width: 5,) ,

        TextButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
                count++;
              });

              await shoppingCart.addItemTOShoppingCart(widget.productId, count);

              setState(() {
                _isLoading = false;
              });
            },
            child: const Icon(
              Icons.add_circle_outline_rounded ,

            )
        ) ,
      ],

    );
  }
}
