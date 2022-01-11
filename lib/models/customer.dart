import './user.dart';

class Customer extends User {

  Customer({
    required int id ,
    required String apiKey ,
    required String firstName ,
    required String lastName ,
    required String phoneNumber

  }) : super(
      id: id ,
      apiKey:  apiKey ,
      firstName: firstName ,
      lastName: lastName ,
      phoneNumber: phoneNumber
   );

}