import 'package:flutter/material.dart';

import '../../models/item.dart';

class VendorItem extends StatefulWidget {

  final Item item;

  const VendorItem({Key? key , required this.item}) : super(key: key);

  @override
  _VendorItemState createState() => _VendorItemState();
}

class _VendorItemState extends State<VendorItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
