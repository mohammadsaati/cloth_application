class ShoppingCartItem
{
    final int id;
    final String slug;
    final int count;
    final int price;
    final int totalPrice;
    final String image;

    ShoppingCartItem({
        required this.id ,
        required this.slug ,
        required this.count  ,
        required this.price ,
        required this.totalPrice ,
        required this.image
    });

    static List<ShoppingCartItem> fillShoppingCartItems(loadedItems)
    {
        List<ShoppingCartItem> cartItems = [];

        for(var item in loadedItems)
        {
            cartItems.add(
                ShoppingCartItem(
                    id: item["product_id"],
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
