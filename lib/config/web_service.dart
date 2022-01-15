import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

const  String baseUrl = "http://192.168.1.110:800/";

Future<Response> sendGetRequest({ required String url }) async
{
    try {

      final Response response = await get( Uri.parse( url ) ,
        headers: {
            "Authorization" : "XmmfGkBKjhcjKx7sgQbm1637684319eafffcb7-c33f-43d0-a57a-465a9f"
        }
      );

      if(response.statusCode != 200)
      {
          throw ServiceExtensionResponse.error(response.statusCode, jsonDecode( response.body )["message"] );
      }

      return response;

    } catch(error) {
      rethrow;
    }
}


Future<Response> sendPostRequest({ required String url ,  Map<String , String> givenData = const  {} }) async
{
    try {
      final data = jsonEncode( givenData );

      final Response response = await post( Uri.parse(url) ,
        headers: {
          "Authorization" : "XmmfGkBKjhcjKx7sgQbm1637684319eafffcb7-c33f-43d0-a57a-465a9f"
        } ,
        body: data
      );

      return response;

    } catch(error) {
      rethrow;
    }
}