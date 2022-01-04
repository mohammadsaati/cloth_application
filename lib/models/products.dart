import 'package:flutter/foundation.dart';

import './product_color.dart';
import './size.dart';
import './vendor.dart';

class Product
{
    final int id;
    final String name;
    final String description;
    final String slug;
    final int code;
    final String category;
    late int categoryId;
    final String image;
    List<ProductColor> colors;
    List<Size> sizes;
    List<Vendor> vendors;


    Product(
      {   required this.id,
          required this.name,
          required this.description,
          required this.slug,
          required this.category,
          required this.code,
          required this.image ,
          this.colors =  const [] ,
          this.sizes = const  [] ,
          this.vendors = const [] ,
          this.categoryId = 0
      });

    static List<Product> fillProduct(loadedProducts)
    {
        List<Product> products = [];

        for(var product in loadedProducts)
        {
            products.add(
              Product(
                  id: product["id"],
                  name: product["name"],
                  description: "",
                  slug: product["slug"],
                  category: product["category"],
                  code: product["code"],
                  image: product["image"]
              )

            );
        }

        return products;
    }
}