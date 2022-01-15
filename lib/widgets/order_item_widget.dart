import 'package:flutter/material.dart';

import '../models/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  const OrderItemWidget({Key? key , required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * .25,
              height: MediaQuery.of(context).size.width * .25,
              child:   CircleAvatar(
                radius: 5,
                backgroundImage: NetworkImage( orderItem.image ),
                backgroundColor: Colors.amber,
              ) ,
            ) ,

            const SizedBox( width: 10, ) ,

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.name.length > 25 ?  orderItem.name.substring(0 , 15)+" ..." : orderItem.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold ,
                    fontSize: 16
                  ),
                ) ,

                Text(
                  "Count : "+orderItem.count.toString() ,
                  style: const TextStyle(
                    fontSize: 12 ,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ) ,


                Text(
                  "price : "+orderItem.totalPrice.toString() ,
                  style: const TextStyle(
                      fontSize: 12 ,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ) ,


                Text(
                  "off price : "+orderItem.offPrice.toString() ,
                  style: const TextStyle(
                      fontSize: 12 ,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ) ,

              ],
            ) ,

          ],
        ),
      ),
    );
  }
}
