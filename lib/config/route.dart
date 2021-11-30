import './web_service.dart';

const String currentVersion = "v1/";

const String customerRouteName = "customer/";

const Map<String , String> routes = {
  "add_shopping_cart"                     :          baseUrl+customerRouteName+currentVersion+"shopping_cart/add" ,
  "home"                                  :          baseUrl+customerRouteName+currentVersion+"home"
};