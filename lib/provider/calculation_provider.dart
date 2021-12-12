import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/calculation.dart';
import '../config/route.dart';

class CalculationProvider with ChangeNotifier
{
    Future<Calculation> getCalculation() async
    {
        try {

          final routeName = routes["calculation"].toString();

          final Response response = await post( Uri.parse( routeName ) ,

            headers: {
              HttpHeaders.authorizationHeader : "" ,
              "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
            },

          );

          final body = jsonDecode(response.body)["data"];

          return Calculation(price: body["price"]);

        } catch(error) {
          rethrow;
        }
    }
}