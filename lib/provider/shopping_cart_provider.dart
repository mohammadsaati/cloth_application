import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/shopping_cart.dart';
import '../config/route.dart';
import '../config/web_service.dart';
import '../config/post_request.dart';
import '../config/get_request.dart';

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
        final String route = routes["add_shopping_cart"].toString();

        final sendData = {
            "product_id" : productId.toString() ,
            "count" : count.toString()
        };

        final Response response = await sendRequest(requestInterFace: PostRequest(), url: route , givenData: sendData);


        increaseTotalItems();

        notifyListeners();
    }

    Future<ShoppingCart> getShoppingCart() async
    {
        final String route = routes["get_shopping_cart"].toString();

        final Response response = await sendRequest(requestInterFace: GetRequest(), url: route);

        final body = jsonDecode(response.body)["data"];

        return ShoppingCart.fillData(body);
    }

}