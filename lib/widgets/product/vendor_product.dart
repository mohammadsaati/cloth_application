import 'package:flutter/material.dart';

import '../../models/vendor.dart';
import '../product/vendor_item.dart';

class VendorProduct extends StatefulWidget {

  final Vendor vendor;

  const VendorProduct({Key? key , required this.vendor}) : super(key: key);

  @override
  _VendorProductState createState() => _VendorProductState();
}

class _VendorProductState extends State<VendorProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5) ,
      width: double.infinity,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5) ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vendor.companyName ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold ,
                  fontFamily: "IRANSans" ,
                  fontSize: 16
                ),
                textAlign: TextAlign.center

              ) ,

              const SizedBox(height: 10,) ,

              Text(
                  widget.vendor.firstName+" "+widget.vendor.lastName ,
                  style: const TextStyle(
                    fontSize: 10 ,
                    fontFamily: "IRANSans" ,
                    color: Colors.white30
                  ),
              ) ,

              const SizedBox(height: 15,) ,

              Column(
                children: widget.vendor.items.map((item) {
                  return VendorItem(item: item);
                }).toList(),
              ) ,

            ],
          ),
        ),
      )
    );
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
