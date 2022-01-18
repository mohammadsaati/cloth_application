import 'dart:convert';
import 'dart:developer';

import 'package:cloth_app/config/web_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/route.dart';

class AuthProvider with ChangeNotifier{

  bool _hasToke = false;

  bool get hasToken {
      return _hasToke;
  }

  Future<String> getTokenFormSharedPreferences() async{

    final sharedPreferenceInit = await SharedPreferences.getInstance();


    return sharedPreferenceInit.getString("customerToken").toString();

  }


  Future<String> getTokenFromServer() async {

    try {
      String apiKey = "";

      final String localToken = await getTokenFormSharedPreferences();

      final Response response = await get( Uri.parse( routes["splash"].toString() ) ,
          headers: {
                "Authorization" : localToken
          }
      );

      print(response.statusCode);

      if( response.statusCode != 200 ) {
        throw ServiceExtensionResponse.error(response.statusCode,  jsonDecode( response.body )["message"] );
      }

      final body = jsonDecode( response.body )["data"];

      print(body);

      if(body["customer_info"] != "") {

        apiKey = body["customer_info"]["api_key"];

      } else {

        apiKey = "";

      }

      return apiKey;

    } catch(error) {
      rethrow;
    }

  }

  Future<void> checkToken() async {
    final String preferencesToken = await getTokenFormSharedPreferences();
    final String apiToken = await getTokenFromServer();

    print("*********************************");
    print(preferencesToken);
    print(apiToken);
    print("*********************************");


    if(preferencesToken == "" && apiToken == "") {
      _hasToke = false;
      notifyListeners();
    }
    else if(preferencesToken == apiToken) {
      _hasToke = true;
      notifyListeners();

    }else {
      _hasToke = false;
      notifyListeners();
    }



  }


  Future<void> customerGetCode(String phoneNumber) async
  {
      final route = routes["resend_code"].toString();

      final Response response  = await sendPostRequest(url: route , givenData: { "phone_number" : phoneNumber });

      print(response.body);
  }

  Future<void> customerLogin({ required String phoneNumber , required String activationCode , required String password }) async
  {
      final route = routes["customer_login"].toString();

      final Map<String , String> data = {
        "phone_number"  : phoneNumber ,
        "activation-code" : activationCode,
        "password" : password
      };

      final Response response = await sendPostRequest(url: route , givenData: data);

      final body = jsonDecode( response.body )["customer"];

      final sharedPreferenceInit = await SharedPreferences.getInstance();

      sharedPreferenceInit.setString("customerToken", body["api_key"]);
  }

}
