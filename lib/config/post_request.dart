import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/request_interface.dart';

class PostRequest extends RequestInterFace
{

  @override
  Future<Response> sendRequest({ required String url ,  Map<String , String> givenData = const  {} }) async {

    try {
      final data = jsonEncode( givenData );
      final sharedPreferences = await SharedPreferences.getInstance();

      final String customerToken =  sharedPreferences.getString("customerToken").toString();

      final Response response = await post( Uri.parse(url) ,
          headers: {
            "Content-Type" : "application/json" ,
            "Authorization" : customerToken ,
            "SHOPPING-KEY" : "1zt51HyXUT1Da1lIxR7z1638291822672e4b43-d3dc-453f-a1a4-515b91"
          } ,
          body: data
      );

      print(response.statusCode);
      print(data);

      if(response.statusCode != 200)
      {
        throw ServiceExtensionResponse.error(response.statusCode, jsonDecode( response.body )["message"] );
      }

      return response;

    } catch(error) {
      rethrow;
    }

  }


}