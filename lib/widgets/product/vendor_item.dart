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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        /*
          Show item color and size which is belongs to tha vendor
         */
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // color
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               const Text(
                  "color : " ,
                 style: TextStyle(
                    fontWeight: FontWeight.bold
                 ),
                ) ,

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50) ,
                      color: HexColor.fromHex( widget.item.color.code )
                  ),
                )

              ],
            ) ,

            const SizedBox(width: 50,) ,

            //size
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "size : " ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ) ,

                 Text(
                   widget.item.size ,
                  style: const TextStyle(
                      fontSize: 15
                  ),
                ) ,

              ],
            ) ,
            
          ],
          
        ) , 


        const SizedBox( height: 20, ) ,

        // Show that item price
        Text(
          widget.item.price.toString()+"\$" ,
          style: const TextStyle(
            fontSize: 15 ,
            color: Colors.grey
          ),

        ) ,
        
      ],
      
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
