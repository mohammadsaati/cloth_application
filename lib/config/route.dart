import './web_service.dart';

const String currentVersion = "v1/";

const String customerRouteName = "customer/";

const Map<String , String> routes = {
  "add_shopping_cart"                     :          baseUrl+customerRouteName+currentVersion+"shopping_cart/add" ,
  "get_shopping_cart"                     :          baseUrl+customerRouteName+currentVersion+"shopping_cart/get" ,
  "calculation"                           :          baseUrl+customerRouteName+currentVersion+"order/calculation" ,
  "home"                                  :          baseUrl+customerRouteName+currentVersion+"home",
  "splash"                                :          baseUrl+customerRouteName+currentVersion+"splash",
  "search"                                :          baseUrl+customerRouteName+currentVersion+"search" ,
  "order_submit"                          :          baseUrl+customerRouteName+currentVersion+"order/submit" ,
  "order_list"                            :          baseUrl+customerRouteName+currentVersion+"order" ,
  "customer_address"                      :          baseUrl+customerRouteName+currentVersion+"address" ,
  "resend_code"                           :          baseUrl+customerRouteName+"resend-code" ,
  "customer_login"                        :          baseUrl+customerRouteName+"login" ,
};

String vendorItemsRoute({required String slug , required int vendorId})
{
  return baseUrl+customerRouteName+currentVersion+"product/"+slug+"/vendor/"+vendorId.toString();
}

String orderDetailRoute( int orderId )
{
    return baseUrl+customerRouteName+currentVersion+"order/show/"+orderId.toString();
}

String showProductRoute( { required String slug , String size = "" , String color = "" } )
{
  return baseUrl+customerRouteName+currentVersion+slug+"?color=$color&size=$size";
}
