import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/products.dart';
import '../config/web_service.dart';
import '../models/product_color.dart';
import '../models/size.dart';
import '../models/vendor.dart';

class ProductProvider with ChangeNotifier
{
    late List<Product> _product;

    List<Product> get product
    {
        return [...product];
    }


    Future<void> showProduct2({required String  slug, String size = "" , String color = ""}) async
    {
            print("");
    }


    Future<Product> showProduct({required String  slug, String size = "" , String color = ""}) async
    {
        try{

            Response response = await get(
                Uri.parse(baseUrl+"customer/v1/product/$slug?color=$color&size=$size") ,
                headers: { HttpHeaders.contentTypeHeader : "application/json" }
            );


            if(response.statusCode != 200)
            {
                throw ServiceExtensionResponse.error(response.statusCode, jsonDecode(response.body)["title"] );
            }

            final body = jsonDecode( response.body )["data"];

            print(body);
            List<ProductColor> colors = ProductColor.fill(loadedColors: body["colors"]);

            List<Size> sizes = Size.fill(loadedSize: body["sizes"]);

            List<Vendor> vendors = Vendor.fill(loadedVendor: body["vendors"]);

            return  Product(
                id: body["id"],
                name: body["name"],
                description: body["description"],
                slug: body["slug"],
                category: "category",
                code: 0,
                image: body["images"] ,
                colors: colors ,
                sizes: sizes ,
                vendors: vendors
            );

        }
        catch(error) {
            rethrow;
        }
    }


    Future<void> getHomeProducts() async
    {
        Response response = await get( Uri.parse(baseUrl+"customer/v1/home") , headers: { HttpHeaders.contentTypeHeader : "application/json" } );

        print(response.body);
    }

}
