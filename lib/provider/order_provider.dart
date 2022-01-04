import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../config/route.dart';

class OrderProvider with ChangeNotifier {


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

}