import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/shopping_cart.dart';
import '../config/route.dart';

class ShoppingCartProvider with ChangeNotifier
{
    List<ShoppingCart> _shoppingCart = [];
    int _totalItems = 0;

    List<ShoppingCart> get shoppingCart
    {
       return [..._shoppingCart];
    }

    int get totalItems
    {
        return _totalItems;
    }


    void increaseTotalItems()
    {
        _totalItems++;
    }

    Future<void> addItemTOShoppingCart(int productId , int count) async
    {
        final String routeName = routes["add_shopping_cart"].toString();



        try{

            final Response response = await post( Uri.parse( routes["add_shopping_cart"].toString() ) ,

                headers: {
                    HttpHeaders.authorizationHeader : "" ,
                    "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
                },
                body: {
                    "product_id" : productId.toString() ,
                    "count" : count.toString()
                }
            );


            increaseTotalItems();

            notifyListeners();

        } catch(error) {
            rethrow;
        }
    }

    Future<ShoppingCart> getShoppingCart() async
    {
        final String routeName = routes["get_shopping_cart"].toString();

        try {

            final Response response = await get( Uri.parse( routeName )  ,
                headers:
                {
                    HttpHeaders.authorizationHeader : "" ,
                    "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
                }
            );

            if(response.statusCode != 200)
            {
                throw ServiceExtensionResponse.error(response.statusCode, "Error");
            }

            final body = jsonDecode(response.body)["data"];

            print(body);
            return ShoppingCart.fillData(body);

        } catch(error) {
            rethrow;
        }
    }

}