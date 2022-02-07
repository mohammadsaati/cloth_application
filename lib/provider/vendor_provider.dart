import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/item.dart';
import '../config/route.dart';
import '../config/web_service.dart';
import '../config/get_request.dart';

class VendorProvider with ChangeNotifier
{
    List<Item> _items = [];

    List<Item> get getItems
    {
      return [..._items];
    }

    Future<List<Item>> getVendorItems({required String slug , required int vendorId}) async
    {

      String route = vendorItemsRoute(slug: slug, vendorId: vendorId);

      final Response response = await sendRequest(requestInterFace: GetRequest(), url: route);

      final body = jsonDecode(response.body)["data"];

      return Item.fillVendorItems( body );

    }
}