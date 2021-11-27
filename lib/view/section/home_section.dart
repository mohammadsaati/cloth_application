import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/section.dart';
import '../../widgets/product/section_product.dart';

class HomeSection extends StatelessWidget {

  final Section section;

   const HomeSection({Key? key , required this.section}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0 , horizontal: 2.0),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(5) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(
                section.title ,
                textAlign: TextAlign.right,
              ) ,

              const SizedBox(height: 10,) ,

              section.product.isNotEmpty ? Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder:  (ctx , product) => SectionProduct(product: section.product[product]),
                  itemCount: section.product.length ,
                )
              ): const Text(
                "no product" ,
                style: TextStyle(
                    fontFamily: "IRANSans"
                ),
                textAlign: TextAlign.center,
              ) ,

              const SizedBox(height: 3,) ,

              
            ],
          ),
        ),
      ),
    );
  }
}
