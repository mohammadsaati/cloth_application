import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/calculation.dart';
import '../config/route.dart';
import '../config/web_service.dart';
import '../config/post_request.dart';

class CalculationProvider with ChangeNotifier
{
    Future<Calculation> getCalculation() async
    {
      final route = routes["calculation"].toString();

      final Response response = await sendRequest(requestInterFace: PostRequest(), url: route);

      final body = jsonDecode(response.body)["data"];

      return Calculation(price: body["price"]);

    }
}