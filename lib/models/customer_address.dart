class CustomerAddress
{
    final int id;
    final String city;
    final String fullAddress;
    final String phoneNumber;

    CustomerAddress({
      required this.id ,
      required this.city ,
      required this.fullAddress ,
      required this.phoneNumber
    });

    static List<CustomerAddress> fillAddress(loadedAddress)
    {
        List<CustomerAddress> addresses = [];

        for(var address in loadedAddress)
        {
            addresses.add(
              CustomerAddress(id: address["id"],
                  city: address["city"],
                  fullAddress: address["full_address"],
                  phoneNumber: address["phone_number"]
              )
            );
        }

        return addresses;
    }
}