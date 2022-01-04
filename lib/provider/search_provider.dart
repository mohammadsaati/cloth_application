import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/products.dart';
import '../models/category.dart';
import '../models/product_color.dart';
import '../models/size.dart';

import '../config/route.dart';

class SearchProvider with ChangeNotifier
{
    List<int> _loadedCategoryIds = [];
    List<Category> _categories = [];
    List<Category> _subCategories = [];
    List<Product> _products = [];
    List<ProductColor> _productColors = [];
    List<Size> _productSizes = [];

    // Attribute getter
    List<int> get categoryIds
    {
        return [..._loadedCategoryIds];
    }

    List<Category> get categories
    {
        return [..._categories];
    }

    List<Category> get subCategories
    {
        return [..._subCategories];
    }


    List<Product> get products
    {
        return [..._products];
    }

    List<ProductColor> get productColors
    {
        return [..._productColors];
    }

    List<Size> get productSizes
    {
        return [..._productSizes];
    }


    // Send http Request

    Future<void> searchProduct({ List<int> categoryIds = const [] , List<int> colorIds = const [] }) async
    {
        final data = jsonEncode({
            "category_ids"      :   categoryIds ,
            "color_ids"         :   colorIds
        });


        print(data);

        try {

            final Response response = await post( Uri.parse( routes["search"].toString() )  ,
                headers: {
                    HttpHeaders.authorizationHeader : "" ,
                    "Content-Type" : "application/json" ,
                    "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
                } ,

                body: data

            );

            if(response.statusCode != 200)
            {
                throw ServiceExtensionResponse.error(response.statusCode, "some error occurred");
            }
            
            final body = jsonDecode( response.body )["data"];


            //filling  data

            _products = Product.fillProduct( body["items"] );
            _productColors = ProductColor.fill(loadedColors: body["colors"]);
            _productSizes = Size.fill(loadedSize: body["sizes"]);
            _categories = Category.fillCategories( body["categories"] );
            _subCategories = Category.fillCategories( body["sub_categories"] );

            notifyListeners();

        } catch (error) {
            rethrow;
        }
    }


}