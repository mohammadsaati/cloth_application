import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/slider.dart';

class HomeSliders extends StatelessWidget {

  final List<ImageSlider> imageSlider;

  const HomeSliders({Key? key , required this.imageSlider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              height: 200.0 ,
              autoPlay: true ,
              aspectRatio: 16/9 ,
              autoPlayCurve: Curves.fastOutSlowIn ,
              autoPlayAnimationDuration: const Duration( milliseconds: 800 )
            ),
            items: imageSlider.map((imageSlider) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0 , horizontal: 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10) ,
                ) ,
                child: Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                      imageSlider.image ,
                      loadingBuilder: (context , child , progress) => progress == null ? child : Container(
                        width: double.infinity,
                        height: 200,
                        child: const Center(child: CircularProgressIndicator(),),
                      ),
                      fit: BoxFit.cover,

                    )
                  ),

                ),
              );
            }).toList(),
        ) ,
      ],
    );
  }
}
