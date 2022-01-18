import 'package:flutter/material.dart';

import '../view/order_screen.dart';
import '../view/home.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width * .75,

        child: ListView(
          children:  [
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.amber,
              padding: const EdgeInsets.all(10),
              child: const Text(
                  "Cloth App" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold ,
                  fontSize: 25
                ),
              ),
            ) ,

            const SizedBox(height: 20,) ,


            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon( Icons.home ) ,
                    SizedBox(width: 5,) ,
                    Text(
                      "Home" ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold ,
                          fontSize: 16
                      ),
                    )
                  ],
                ),
              ) ,
            ),
            const SizedBox(height: 5,) ,
           InkWell(
             onTap: () {
                Navigator.pushNamed(context, OrderScreen.routeName);
             },
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: const [
                   Icon( Icons.shopping_cart ) ,
                   SizedBox(width: 5,) ,
                   Text(
                     "Orders" ,
                     style: TextStyle(
                         fontWeight: FontWeight.bold ,
                         fontSize: 16
                     ),
                   )
                 ],
               ),
             ) ,
           ),








          ],
        ),
      )
    );
  }
}
