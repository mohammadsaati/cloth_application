class OrderItem {
  final int id;
  final int productId;
  final String name;
  final String image;
  final int count;
  final int offPrice;
  final int totalPrice;


  OrderItem({
      required this.id ,
      required this.productId ,
      required this.name ,
      required this.image ,
      required this.count ,
      required this.offPrice ,
      required this.totalPrice
  });


  static List<OrderItem> fillOrderItem(loadedItems)
  {
      List<OrderItem> orderItems = [];

      for(var item in loadedItems)
      {
          orderItems.add(
            OrderItem(
                id: item["id"],
                productId: item["product_id"],
                name: item["name"],
                image: item["image"],
                count: item["count"],
                offPrice: item["off_price"],
                totalPrice: item["total_price"]
             )
          );
      }
      return orderItems;
  }

}