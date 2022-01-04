import 'package:flutter/material.dart';

import '../models/size.dart';

class SearchSizeWidget extends StatelessWidget {

  final Size size;
  const SearchSizeWidget({Key? key , required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 80,
      height: 30,
      child: Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
        elevation: 5,
        child: Text(
          size.value ,
          style: const TextStyle(
            fontWeight: FontWeight.bold ,
            fontSize: 16
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
