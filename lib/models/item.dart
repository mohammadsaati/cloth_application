import './product_color.dart';
import './price.dart';

class Item
{
    final int id;
    final ProductColor color;
    final String size;
    final int stock;
    final int price;
    late List<Price> priceChange;


    Item({
        required this.id ,
        required this.color ,
        required this.size ,
        required this.price ,
        required this.stock ,
        this.priceChange = const  []
    });

    static List<Item> fillVendorItems(loadedItems)
    {
        List<Item> items = [];

        if(loadedItems != null)
        {
            for(var loadedItem in loadedItems)
            {


                items.add(
                    Item(
                        id: loadedItem["id"],
                        color:  ProductColor(id: loadedItem["color"]["id"], name: loadedItem["color"]["color"], code: loadedItem["color"]["code"]),
                        size: loadedItem["size"],
                        price: loadedItem["current_price"] != null ? loadedItem["current_price"]["price"] : 0,
                        stock: loadedItem["stock"]
                    )
                );
            }
        }


        return items;
    }
}