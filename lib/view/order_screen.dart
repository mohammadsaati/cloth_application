import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app.dart';
import '../widgets/app_bar_cart_item.dart';
import '../models/order.dart';
import '../provider/order_provider.dart';
import '../widgets/drawer_widget.dart';

import './order_detail_screen.dart';

class OrderScreen extends StatefulWidget {

  static const String routeName = "order_page";

  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  bool _isloading = true;
  bool _isInit = true;
  List<Order> orders = [];

  @override
  void didChangeDependencies() async {

    if(_isInit)
    {
        final orderProvider = Provider.of<OrderProvider>(context);

        await orderProvider.getOrderList();

        setState(() {
          orders = orderProvider.orders;
          _isloading = false;
        });
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
        title: const Text(appName),
        actions: const [
          AppBarCartIcon()
        ],
      ),

      body: _isloading ?
      const Center(child: CircularProgressIndicator() ,) :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: orders.map((order) {
              return InkWell(
                onTap: () async {
                    Navigator.of(context).pushNamed(OrderDetailScreen.routeName , arguments: order.id);
                    // await Provider.of<OrderProvider>(context , listen: false).getOrderDetails(12);
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(10) ,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "amount : "+order.amount.toString() ,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ) ,

                          const SizedBox(height: 10,) ,

                          Text(
                            "off price : "+order.offPrice.toString() ,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ) ,

                          const SizedBox(height: 10,) ,
                          Text(
                            "address : "+order.address ,
                            style: const TextStyle(
                                fontSize: 13 ,
                                color: Colors.grey
                            ),
                          ) ,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
