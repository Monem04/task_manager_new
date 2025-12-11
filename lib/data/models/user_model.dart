class UserModel{
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;

  UserModel({required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String,dynamic>jsonData){
    return UserModel(id: jsonData['_id'],
        email: jsonData['_email'],
        firstName: jsonData['_firstName'],
        lastName: jsonData['_lastName'],
        mobile: jsonData['_mobile'],
        photo: jsonData['_mobile'] ?? '',
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "_id":id,
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,

    };
  }
}