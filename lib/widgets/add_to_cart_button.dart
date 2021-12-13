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
  bool added = false;

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

    return added ? const Icon(
      Icons.assignment_turned_in_sharp ,
      color: Colors.green,
    ) :ElevatedButton(
      onPressed: () async{
        setState(() {
          added = true;
        });

        await shoppingCart.addItemTOShoppingCart(widget.productId, 1);

      },
      child: const Text(
        "Add" ,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
