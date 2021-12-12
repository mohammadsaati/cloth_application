import './product_color.dart';
import './size.dart';

class ShoppingCartItem
{
    final int id;
    final String name;
    final String slug;
    int count;
    final int price;
    final int totalPrice;
    final String image;
    final ProductColor color;
    final Size size;

    ShoppingCartItem({
        required this.id ,
        required this.name ,
        required this.slug ,
        required this.count  ,
        required this.price ,
        required this.totalPrice ,
        required this.image ,
        required this.color ,
        required this.size
    });

    static List<ShoppingCartItem> fillShoppingCartItems(loadedItems)
    {
        List<ShoppingCartItem> cartItems = [];

        for(var item in loadedItems)
        {
            cartItems.add(
                ShoppingCartItem(
                    id: item["product_id"],
                    name: item["name"],
                    color: ProductColor(name: item["color"]["name"] , code: item["color"]["code"]),
                    size: Size(value: item["size"]),
                    slug: item["slug"],
                    count: item["count"] ,
                    price: item["price"] ,
                    totalPrice: item["total_price"] ,
                    image: item["image"]
                )
            );
        }

        return cartItems;
    }
}
