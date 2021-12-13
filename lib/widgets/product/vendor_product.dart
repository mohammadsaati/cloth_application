import 'package:cloth_app/provider/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/vendor.dart';
import '../../models/item.dart';
import '../product/vendor_item.dart';
import '../../provider/vendor_provider.dart';

class VendorProduct extends StatefulWidget {

  final Vendor vendor;
  final String slug;

  const VendorProduct({Key? key , required this.vendor , required this.slug}) : super(key: key);

  @override
  _VendorProductState createState() => _VendorProductState();
}

class _VendorProductState extends State<VendorProduct> {
  List<Item> vendorItems = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5) ,
      width: 300,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5) ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    child: Icon(
                      Icons.person  ,
                      size: 30,
                    ),
                  ) ,

                  const SizedBox( width: 10,) ,

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        constraints: const BoxConstraints(
                          maxWidth: 200
                        ),
                        child: Text(
                          widget.vendor.firstName+ " " +widget.vendor.lastName ,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold ,
                              fontSize: 16
                          ),
                        ) ,
                      ) ,

                      const SizedBox(height: 5,) ,

                      Text(
                        widget.vendor.companyName ,
                        style: const TextStyle(
                          fontSize: 10 ,
                          fontWeight: FontWeight.bold ,
                          color: Colors.grey
                        ),
                      ) ,

                      const SizedBox(height: 5,) ,

                      Text(
                        "Phone number : "+widget.vendor.phoneNumber ,
                        style: const TextStyle(
                            fontSize: 10 ,
                            fontWeight: FontWeight.bold ,
                            color: Colors.grey
                        ),
                      ) ,

                      TextButton(
                          onPressed: () async {
                            final loadedVendorItems = await Provider.of<VendorProvider>(context , listen: false).getVendorItems(slug: widget.slug, vendorId: 19);
                            setState(() {
                              vendorItems = loadedVendorItems;
                            });

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      width: 350,
                                      height: 300,
                                      child: Card(
                                        child: ListView.builder(
                                            itemBuilder: (context , index) =>  VendorItem(item: vendorItems[index]),
                                            itemCount: vendorItems.length,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );

                          },
                          child: const Text(
                              "see products" ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold ,
                                fontSize: 12
                              ),
                          )
                      ) ,

                    ],
                  ) ,
                ],
              ) ,
              const SizedBox(height: 15,) ,

            /*  Column(
                children: widget.vendor.items.map((item) {
                  return VendorItem(item: item);
                }).toList(),
              ) ,*/

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
