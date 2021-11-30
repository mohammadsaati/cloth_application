import './shopping_cart_item.dart';

class ShoppingCart
{
    final int id;
    late int customerId;
    late String shoppingKey;
    List<ShoppingCartItem> items;

    ShoppingCart({ required this.id  , this.customerId = 0 , this.shoppingKey = "" , this.items = const [] });
}