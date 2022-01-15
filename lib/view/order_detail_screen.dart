import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app.dart';
import '../widgets/app_bar_cart_item.dart';
import '../models/order_item.dart';
import '../provider/order_provider.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/order_item_widget.dart';


class OrderDetailScreen extends StatefulWidget {

  static const String routeName = "order-details";
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  bool _isInit = true;
  bool _isLoading = true;
  List<OrderItem> _orderItems = [];

  @override
  void didChangeDependencies() async {

    final int givenData = ModalRoute.of(context)!.settings.arguments as int;
    print("****************************************************");
    print(givenData);

    if(_isInit) {

      final orderProvider = Provider.of<OrderProvider>(context , listen: false);

      final orderItemList = await orderProvider.getOrderDetails(givenData);

      setState(() {
        _orderItems = orderItemList;
        _isLoading = false;
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

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
            itemCount: _orderItems.length,
            itemBuilder: (context , index) {
              return OrderItemWidget(orderItem: _orderItems[index]);
            }
        ),
        ),

      drawer: const DrawerWidget(),
    );
  }
}
