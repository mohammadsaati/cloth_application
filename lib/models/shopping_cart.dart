import './shopping_cart_item.dart';

class ShoppingCart
{
    final int id;
    List<ShoppingCartItem> items;

    ShoppingCart({ required this.id  , this.items = const [] });

    static ShoppingCart fillData(loadedCart)
    {
        List<ShoppingCartItem> cartItems = ShoppingCartItem.fillShoppingCartItems(loadedCart["items"]);

        return ShoppingCart(
            id: loadedCart["id"] ,
            items: cartItems
        );
    }
}