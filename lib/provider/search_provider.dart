import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloth_app/config/post_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/products.dart';
import '../models/category.dart';
import '../models/product_color.dart';
import '../models/size.dart';

import '../config/route.dart';
import '../config/web_service.dart';
import '../config/get_request.dart';

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
        final data = {
            "category_ids"      :   categoryIds.toString() ,
            "color_ids"         :   colorIds.toString()
        };

        String route = routes["search"].toString();

        final Response response = await sendRequest(requestInterFace: PostRequest(), url: route , givenData: data);

        final body = jsonDecode( response.body )["data"];

        print(data);

        _products = Product.fillProduct( body["items"] );
        _productColors = ProductColor.fill(loadedColors: body["colors"]);
        _productSizes = Size.fill(loadedSize: body["sizes"]);
        _categories = Category.fillCategories( body["categories"] );
        _subCategories = Category.fillCategories( body["sub_categories"] );

        notifyListeners();
    }


}