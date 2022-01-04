import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';
import '../config/app.dart';
import '../widgets/app_bar_cart_item.dart';
import '../widgets/search_category_widget.dart';
import '../widgets/product/section_product.dart';
import '../widgets/search_sizes_widget.dart';
import '../widgets/search_color_widget.dart';

import '../models/products.dart';
import '../models/category.dart';
import '../models/product_color.dart';
import '../models/size.dart';

class SearchScreen extends StatefulWidget {
  List<int> categoriesId;
  List<int> widgetColorIds;

  SearchScreen({
    Key? key ,
    this.categoriesId = const [] ,
    this.widgetColorIds = const []
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  bool _isLoading = true;
  bool _isInit = true;
  bool _showMoreFilter = false;
  List<Category> _categories = [];
  List<Category> _subCategories = [];
  List<Product> _products = [];
  List<ProductColor> _productColors = [];
  List<Size> _productSizes = [];

  void getFilteredData({ List<int> catIds = const []  , List<int> colors = const []}) async
  {
      setState(() {
        _isLoading = true;
      });


      try {

        final searchProvider = Provider.of<SearchProvider>(context , listen: false);

        await searchProvider.searchProduct( categoryIds: widget.categoriesId  , colorIds: colors);

        setState(() {
          _categories = searchProvider.categories;
          _subCategories = searchProvider.subCategories;
          _productColors = searchProvider.productColors;
          _productSizes = searchProvider.productSizes;
          _products = searchProvider.products;
        });

      } catch(error) {

        print(error);

        return showDialog(
            context: context,
            builder: (context) {

              return const AlertDialog(
                title:  Text("warning"),
                content: Text("Please try again!"),
              );

            }

        );
      }

      setState(() {
        _isLoading = false;
      });
  }

  @override
  void didChangeDependencies() async {

    if(_isInit)
    {
       getFilteredData();
    }

    setState(() {
      _isInit = false;
    });


    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text( appName ),
        actions: const [
          AppBarCartIcon()
        ],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(),) :

      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //Show sub categories

            Container(
              width: double.infinity,
              height: 75,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index) {
                    return InkWell(
                      onTap: () {
                        widget.categoriesId.add( _subCategories[index].id );

                        getFilteredData(catIds: widget.categoriesId);
                      },
                      child: SearchCategoryWidget( categoryName: _subCategories[index].name ),
                    );
                  } ,
                itemCount: _subCategories.length,
              ),
            ) ,

          const SizedBox(height: 10,) ,

          const Padding(
              padding: EdgeInsets.symmetric(vertical: 0 ,horizontal: 20) ,
              child: Text(
                "Sizes" ,
                style: TextStyle(
                    fontWeight: FontWeight.bold ,
                    fontSize: 20
                ),
              ),
          ) ,

          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.all(3),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _productSizes.length,
                itemBuilder: (context , index) {
                  return InkWell(
                    onTap: () {

                    },
                    child: SearchSizeWidget(size: _productSizes[index]),
                  );
                }
            ),
          ) ,

            //Shoe more filters

           InkWell(
             onTap: () {
               setState(() {
                 _showMoreFilter = !_showMoreFilter;
               });
             },
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 6 , horizontal: 15) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const Text(
                      "More filter" ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    )   ,

                    Icon(
                        _showMoreFilter ? Icons.arrow_drop_up : Icons.arrow_drop_down_sharp
                    )
                  ],

                ) ,
              ),
           ) ,

          _showMoreFilter ? Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _productColors.length,
                itemBuilder: (context , index) {
                  return InkWell(
                    onTap: () {
                      widget.widgetColorIds.isEmpty ? widget.widgetColorIds = [ _productColors[index].id ] : widget.widgetColorIds.add(_productColors[index].id);

                      widget.widgetColorIds.add(_productColors[index].id);
                      getFilteredData(colors: widget.widgetColorIds);
                    },
                    child: SearchColorWidget( color: _productColors[index], ),
                  );
                }
            ),
          )  : Container(),

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            padding: const EdgeInsets.all(15),
            child:   GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2 ,
                 crossAxisSpacing: 20 ,
              ),
              itemBuilder: (context , index) {
                return Card(
                  elevation: 8,
                  child: SectionProduct(product: _products[index]),
                );
              },
              itemCount: _products.length,
            ) ,
          ),

           const SizedBox(height: 30,) ,



          ],
        )

      )

    );
  }
}
