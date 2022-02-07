import 'package:http/http.dart';

abstract class RequestInterFace
{
     Future<Response> sendRequest({ required String url  , Map<String , String> givenData = const  {}});
}