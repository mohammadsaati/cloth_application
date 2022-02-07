import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../config/route.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../config/web_service.dart';
import '../config/get_request.dart';
import '../config/post_request.dart';

class OrderProvider with ChangeNotifier {

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> submitOrder(String addressId) async
  {
    final sendData = {
      "address_id" : addressId
    };
    final String route = routes["order_submit"].toString();

    final Response response = await sendRequest(requestInterFace: PostRequest(), url: route , givenData: sendData);

    print("************************* Order submit Status Code ********************");
    print(response.statusCode);

  }

  Future<List<OrderItem>> getOrderDetails( int orderId ) async
  {
      final String route = orderDetailRoute(orderId);

      final Response response = await sendRequest(requestInterFace: GetRequest() , url: route);

      return OrderItem.fillOrderItem( jsonDecode( response.body )["data"] );

  }


  Future<void> getOrderList() async {

    final String  route = routes["order_list"].toString();

    final Response response = await sendRequest(requestInterFace: GetRequest() , url: route);

    final body = jsonDecode( response.body )["data"];

    _orders = Order.fillOrders( body );

  }


}