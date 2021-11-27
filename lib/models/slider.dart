import 'package:flutter/cupertino.dart';

class ImageSlider
{
    final String title;
    late int priority;
    late int type;
    final String image;
    late int categoryId;
    late int productId;
    late String link;

    ImageSlider({
      required this.title ,
      required this.image ,
      this.productId = 0 ,
      this.categoryId = 0 ,
      this.priority = 9999 ,
      this.link = "" ,
      this.type = 1
      });

    static List<ImageSlider> fillHomeSliders(loadedSliders)
    {
        List<ImageSlider> sliders = [];

        for(var slider in loadedSliders)
        {
          sliders.add(
            ImageSlider(
                image: slider["image"] ,
                title: slider["title"]
            )
          );
        }

        return sliders;
    }
}