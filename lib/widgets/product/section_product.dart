import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/products.dart';
import '../../view/product/product_details.dart';

class SectionProduct extends StatelessWidget {

  final Product product;

  const SectionProduct({Key? key , required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 100,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetails(productSlug: product.slug) ));
        },
        focusColor: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Image.network(
              product.image,
              width: 80,
              height: 95,
              fit: BoxFit.cover,
              loadingBuilder: (context , child , progress ) => progress == null ? child : const SizedBox( height: 95, width: 80, child: Center( child: Icon(Icons.image))) ,
              errorBuilder: (context , url , error) => const SizedBox( height: 95, width: 80, child: Center( child: Icon(Icons.image), ),
              ),
            ) ,

            const SizedBox(height: 15,) ,

            Text(
              product.name,
              style: const TextStyle(
                  fontFamily: "IRANSans"
              ),
              maxLines: 2,
            ) ,
            const SizedBox(height: 2,) ,


          ],
        ),
      ),
    );
  }
}
