import 'package:flutter/material.dart';

class SearchCategoryWidget extends StatelessWidget {

  final String categoryName;
  const SearchCategoryWidget({Key? key , required this.categoryName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15) ,
        color: const Color(0XA9A9A9B5)
      ),
      constraints: const BoxConstraints(
        maxWidth: 100 ,
        maxHeight: 50
      ),

      child: Text(
        categoryName.length > 10 ? categoryName.substring(0 ,10)+"..." : categoryName ,
        style: const TextStyle(
          color: Colors.black ,
          fontWeight: FontWeight.bold
        ),
      ),

    );
  }
}
