import './web_service.dart';

const String currentVersion = "v1/";

const String customerRouteName = "customer/";

const Map<String , String> routes = {
  "add_shopping_cart"                     :          baseUrl+customerRouteName+currentVersion+"shopping_cart/add" ,
  "get_shopping_cart"                     :          baseUrl+customerRouteName+currentVersion+"shopping_cart/get" ,
  "calculation"                           :          baseUrl+customerRouteName+currentVersion+"order/calculation" ,
  "home"                                  :          baseUrl+customerRouteName+currentVersion+"home",
  "search"                                :          baseUrl+customerRouteName+currentVersion+"search" ,
  "order_submit"                          :          baseUrl+customerRouteName+currentVersion+"order/submit" ,
  "customer_address"                      :          baseUrl+customerRouteName+currentVersion+"address" ,
};

String vendorItemsRoute({required String slug , required int vendorId})
{
  return baseUrl+customerRouteName+currentVersion+"product/"+slug+"/vendor/"+vendorId.toString();
}