import 'dart:ui';

import 'package:cloth_app/widgets/product/section_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../../models/products.dart';
import '../../provider/product_provider.dart';
import '../../config/app.dart';
import '../../widgets/product/vendor_product.dart';
import '../../widgets/app_bar_cart_item.dart';
import '../../view/search_screen.dart';


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
  List<Product> _similars = [];
  dynamic _selectValue = "";


  @override
  void didChangeDependencies() async
  {

    if(isInit)
    {
        setState(() {
          showSpinner = true;
        });

        final productProvider = Provider.of<ProductProvider>(context);

        final  loadedProduct  =  await productProvider.showProduct( slug: widget.productSlug );



        setState(() {
          product = loadedProduct;
          _selectValue = product.sizes.isNotEmpty ? product.sizes[0].value : "";
          _similars = productProvider.similarItems;
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
        actions: const [
          AppBarCartIcon()
        ],
      ),
      body: showSpinner ?  const Center(child: CircularProgressIndicator(),) :

       SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
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

            Padding(
              padding: const  EdgeInsets.symmetric(vertical: 0 , horizontal: 15) ,
              child:  InkWell(
                onTap: () {
                  Navigator.push(
                    context ,
                    MaterialPageRoute(builder: (context) => SearchScreen(categoriesId: [ product.categoryId ],) ) ,
                  );
                },
                child: Text(
                  product.category ,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 12 ,
                      color: Colors.grey
                  ),
                  maxLines: 2,
                ) ,
              ),
            ) ,

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 15) ,
                child: Text(
                  product.name ,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 20
                  ),
                  maxLines: 2,
                ) ,
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
                  "Seller" ,
                  style: TextStyle(
                      fontFamily: "IRANSans" ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 16
                  ),
                  textAlign: TextAlign.start,
                ) ,
           ),

            const SizedBox(height: 10,) ,

            Container(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index) => VendorProduct(vendor: product.vendors[index], slug: product.slug,) ,
                  itemCount: product.vendors.length,
              ),
            ) ,

            const SizedBox(height: 20,) ,

           const Padding(
             padding:  EdgeInsets.all(15) ,
             child: Text(
               "Description" ,

               style: TextStyle(
                 fontWeight: FontWeight.bold ,
                 fontSize: 18
               ),
             ),
           ) ,

            const SizedBox(height: 5,) ,

            Padding(
              padding: const EdgeInsets.all(15),
              child:  Text(
                product.description ,
                maxLines: 20,
                style: const TextStyle(
                    color: Colors.grey
                ),
                textAlign: TextAlign.start,
              ),
            ) ,

            _similars.isNotEmpty ? Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(10) ,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) => Card( elevation: 8, child: SectionProduct(product: _similars[index]), ) ,
                    itemCount: _similars.length,
                )
            ) :
            Container()

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

