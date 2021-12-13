import './item.dart';

class Vendor
{
    final int id;
    final String firstName;
    final String lastName;
    final String phoneNumber;
    final String companyName;
    late List<Item> items;

    Vendor({
      required this.id ,
      required this.firstName ,
      required this.lastName ,
      required this.phoneNumber ,
      required this.companyName ,
      this.items = const  []
    });

    static List<Vendor> fill({required  loadedVendor})
    {
        List<Vendor> vendors = [];

        for(var vendor in loadedVendor)
        {

            vendors.add(
                Vendor(
                    id: vendor["id"],
                    firstName: vendor['first_name'],
                    lastName: vendor['last_name'],
                    phoneNumber: vendor['phone_number'],
                    companyName: vendor['company_name'],
                )
            );
        }

        return vendors;
    }
}