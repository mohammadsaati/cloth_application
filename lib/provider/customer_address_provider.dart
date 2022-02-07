import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/customer_address.dart';
import '../config/route.dart';
import '../config/web_service.dart';
import '../config/get_request.dart';

class CustomerAddressProvider with ChangeNotifier {

  List<CustomerAddress> _addresses = [];

  List<CustomerAddress> get addresses {
    return [..._addresses];
  }

  Future<void> getAddress() async {

    final String route = routes["customer_address"].toString();

    final Response response = await sendRequest(requestInterFace: GetRequest(), url: route);


    final body = jsonDecode( response.body )["data"];

    _addresses = CustomerAddress.fillAddress( body );

    notifyListeners();

  }

}
