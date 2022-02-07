import 'package:http/http.dart';


import '../interfaces/request_interface.dart';

const  String baseUrl = "http://192.168.1.104:800/";
const String loginImage = baseUrl+"storage/login-logo.png";
const String splashImage = baseUrl+"storage/splash.png";


Future<Response> sendRequest( { required RequestInterFace requestInterFace , required String url , Map<String , String> givenData = const  {} } )  async
{
    return requestInterFace.sendRequest(url: url , givenData: givenData);
}
