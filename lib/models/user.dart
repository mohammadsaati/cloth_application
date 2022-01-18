class User {
  final int id;
  final String apiKey;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  User({
    required this.id ,
    required this.apiKey ,
    required this.firstName ,
    required this.lastName ,
    required this.phoneNumber
  });

  static User fillUserInfo( loadedUser ) {

    return User(
        id: loadedUser["id"],
        apiKey: loadedUser["api_key"],
        firstName: loadedUser["first_name"],
        lastName: loadedUser["last_name"],
        phoneNumber: loadedUser["phone_number"]
    );

  }
}