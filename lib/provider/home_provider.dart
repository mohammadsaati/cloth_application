import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../config/web_service.dart';
import '../models/section.dart';
import '../models/slider.dart';
import '../models/products.dart';

class HomeProvider with ChangeNotifier
{
    List<ImageSlider> _sliders = [];
    List<Section> _sections = [];

    List<ImageSlider> get sliders
    {
        return [..._sliders];
    }

    List<Section> get sections
    {
        return [..._sections];
    }



    Future<void> getHomeData() async
    {
        const String path = "customer/v1/home";
        try {
            Response response = await get(
                Uri.parse( baseUrl+ path)  ,
                headers: {
                    HttpHeaders.contentTypeHeader : "application/json" ,
                    }
                );

           /* if(response.statusCode == 500)
            {
                throw ClientException("server error");
            }*/

            final body = jsonDecode( response.body );



            for(final sectionData in body["data"]["sections"])
            {
                List<Product> sectionProducts = [];

                for(final sectionProduct in sectionData["items"])
                {
                    sectionProducts.add(
                        Product(
                            id: sectionProduct["id"] ,
                            slug: sectionProduct["slug"] ,
                            image: sectionProduct["image"] ,
                            category: sectionProduct["category"] ,
                            code: sectionProduct["code"] ,
                            description: "" ,
                            name: sectionProduct["name"]
                        )
                    );
                }


                _sections.add(
                     Section(
                         sectionData["name"],
                         sectionData["slug"],
                         sectionProducts,
                     )
                );
            }

            _sliders = ImageSlider.fillHomeSliders(body["data"]["sliders"]);

            notifyListeners();

            




        } catch(error) {
            rethrow;
        }
    }


}
