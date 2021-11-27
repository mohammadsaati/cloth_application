import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../../models/products.dart';
import '../../provider/product_provider.dart';
import '../../config/app.dart';
import '../../widgets/product/vendor_product.dart';


class ProductDetails extends StatefulWidget {

  final String productSlug;

  const ProductDetails({Key? key , required this.productSlug}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  bool isInit = true;
  bool showSpinner = true;
  late Product product;
  dynamic _selectValue = "";


  @override
  void didChangeDependencies() async
  {

    if(isInit)
    {
        setState(() {
          showSpinner = true;
        });

        final  loadedProduct  =  await Provider.of<ProductProvider>(context).showProduct( slug: widget.productSlug );

        print(loadedProduct.image);

        setState(() {
          product = loadedProduct;
          _selectValue = product.sizes.isNotEmpty ? product.sizes[0].value : "";
          showSpinner = false;
        });

    }

    setState(() {
      isInit = false;
    });

    super.didChangeDependencies();
  }

 void selectColorOrSize({String color = "", String size = ""}) async
  {
      setState(() {
        showSpinner = true;
      });
      final searchedProduct = await Provider.of<ProductProvider>(context , listen: false).showProduct(slug: widget.productSlug , color: color , size: size);

      setState(() {
        product = searchedProduct;
        _selectValue = product.sizes.isNotEmpty ? product.sizes[0].value : "";
        showSpinner = false;
      });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text(appName) ,
      ),
      body: showSpinner ?  const Center(child: CircularProgressIndicator(),) :

       SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            SizedBox(
              width: double.infinity,
              height: 400,
              child: ClipRRect(
                borderRadius: const BorderRadius.only( bottomLeft: Radius.circular(50) ,  bottomRight: Radius.circular(50) ),
                child: Image.network(
                  product.image ,
                  fit: BoxFit.cover,
                  errorBuilder: (context , url , error) => const Center( child: Icon(Icons.image), ),
                ),
              ),
            ) ,

            const SizedBox(height: 10,) ,

           Container(
             height: 50,
             width: double.infinity,
             margin: const EdgeInsets.all(10),
             child: ListView.builder(
               scrollDirection: Axis.horizontal,

               itemBuilder: (ctx , color) =>   InkWell(
                                  onTap: ()  {
                                        selectColorOrSize( color: product.colors[color].name );
                                    },
                                  child:  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle ,
                                          border: Border.all(width: 5 , color: Colors.white ),
                                          color: HexColor.fromHex( product.colors[color].code )
                                      )
                                  )
                                    , ),

               itemCount: product.colors.length,
             ) ,
           ) ,


            const SizedBox( height: 10, ) ,

            Container(
              margin:const  EdgeInsets.symmetric(vertical: 0.0 , horizontal: 20.0),
              width: 70,
              height: 45,
              child: Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: AlignmentDirectional.topEnd,
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    items: product.sizes.isEmpty ? [] : product.sizes.map((size) {
                      return DropdownMenuItem(value : size.value.isNotEmpty ? size.value : "" ,
                          child:Text(size.value.isNotEmpty ? size.value : "") ,
                      );
                    } ).toList(),
                    elevation: 15,
                    onChanged: (dynamic newValue)
                    {

                      setState(() {
                        _selectValue = newValue;
                      });
                    },
                    value: _selectValue,
                    underline: const Text(""),

                  ),
                ),
              ),
            ) ,

           const SizedBox(height: 10,) ,

           const Padding(
               padding: EdgeInsets.symmetric(vertical: 5.0 , horizontal: 10.0) ,
                child:  Text(
                  "فروشندگان" ,
                  style: TextStyle(
                      fontFamily: "IRANSans" ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 16
                  ),
                  textAlign: TextAlign.start,
                ) ,
           ),

            const SizedBox(height: 10,) ,

            Column(
              children: product.vendors.map((vendor)  {
                return VendorProduct(vendor: vendor,);
              }).toList(),
            ) ,

            const SizedBox(height: 10,) ,

          ]
        )
       ),
    ) ;
  }
}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

