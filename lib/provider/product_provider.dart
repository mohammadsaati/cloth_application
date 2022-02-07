import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/products.dart';
import '../config/web_service.dart';
import '../models/product_color.dart';
import '../models/size.dart';
import '../models/vendor.dart';
import '../config/route.dart';
import '../config/get_request.dart';

class ProductProvider with ChangeNotifier
{
    late List<Product> _product;
    List<Product> _similarItems = [];

    List<Product> get product
    {
        return [..._product];
    }
    
    List<Product> get similarItems
    {
        return [..._similarItems];
    }




    Future<Product> showProduct({required String  slug, String size = "" , String color = ""}) async
    {
        String route = showProductRoute(slug: slug , size: size , color: color);

        final Response response = await sendRequest(requestInterFace: GetRequest(), url: route);

        final body = jsonDecode( response.body )["data"];

        print(body);

        List<ProductColor> colors = ProductColor.fill(loadedColors: body["colors"]);

        List<Size> sizes = Size.fill(loadedSize: body["sizes"]);

        List<Vendor> vendors = Vendor.fill(loadedVendor: body["vendors"]);

        _similarItems = Product.fillProduct( body["similar_items"] );

        notifyListeners();

        return  Product(
            id: body["id"],
            name: body["name"],
            description: body["description"],
            slug: body["slug"],
            category: body["category"],
            categoryId: body["category_id"],
            code: 0,
            image: body["images"] ,
            colors: colors ,
            sizes: sizes ,
            vendors: vendors
        );
    }


}
