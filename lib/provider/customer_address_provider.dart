import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/customer_address.dart';
import '../config/route.dart';

class CustomerAddressProvider with ChangeNotifier {

  List<CustomerAddress> _addresses = [];

  List<CustomerAddress> get addresses {
    return [..._addresses];
  }

  Future<void> getAddress() async {
    try {

      final Response response = await get( Uri.parse( routes["customer_address"].toString() )  ,
        headers: {
          HttpHeaders.authorizationHeader : "XmmfGkBKjhcjKx7sgQbm1637684319eafffcb7-c33f-43d0-a57a-465a9f" ,
        }
      );

      final body = jsonDecode( response.body )["data"];

      _addresses = CustomerAddress.fillAddress( body );

      notifyListeners();

    } catch(error) {
      rethrow;
    }
  }

}
