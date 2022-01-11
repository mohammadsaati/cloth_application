import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../config/route.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> submitOrder(String addressId) async
  {
      try {

        Response response = await post(  Uri.parse( routes["order_submit"].toString() ) ,
          headers: {
            HttpHeaders.authorizationHeader : "" ,
            "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
          } ,
          body:  {
              "address_id" : addressId
          }

        );

        print("************************* Order submit Status Code ********************");
        print(response.statusCode);

      } catch (error) {
        rethrow;
      }
  }

  Future<void> getOrderList() async {

    try {

      final Response response = await get( Uri.parse( routes["order_list"].toString() )  ,
        headers: {
          HttpHeaders.authorizationHeader : "XmmfGkBKjhcjKx7sgQbm1637684319eafffcb7-c33f-43d0-a57a-465a9f" ,

        } ,
      );

      final body = jsonDecode( response.body )["data"];

      _orders = Order.fillOrders( body );

      notifyListeners();

    } catch(error) {
      rethrow;
    }

  }


}