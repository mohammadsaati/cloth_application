import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/item.dart';
import '../config/route.dart';

class VendorProvider with ChangeNotifier
{
    List<Item> _items = [];

    List<Item> get getItems
    {
      return [..._items];
    }

    Future<List<Item>> getVendorItems({required String slug , required int vendorId}) async
    {

       try {

         final Response response = await get( Uri.parse( vendorItemsRoute(slug: slug, vendorId: vendorId) ) );

         if(response.statusCode != 200)
         {
            throw ServiceExtensionResponse.error(response.statusCode, "some error");
         }

         final body = jsonDecode(response.body)["data"];

         return Item.fillVendorItems( body );

       } catch(error) {
         rethrow;
       }
    }
}