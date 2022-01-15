class Order {
    final int id;
    final int offPrice;
    final int amount;
    final String address;


    Order({
      required this.id ,
      required this.offPrice ,
      required this.amount ,
      required this.address
    });


    static List<Order> fillOrders(loadedOrders)
    {
        List<Order> orders = [];

        for(var order in loadedOrders)
        {
            orders.add(
              Order(
                  id: order["id"],
                  offPrice: order["off_price"],
                  amount: order["amount"],
                  address: order["address"]
              )
            );
        }

        return orders;
    }
}