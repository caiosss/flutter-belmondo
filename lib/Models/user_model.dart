
class UserModel{
  final String id;
  final String name;
  final String email;
  final String password;
  final bool isAdm;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isAdm,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        isAdm: data['isAdm']
    );

    Map<String, dynamic> toMap() =>
      {'id': id, 
      'name': name, 
      'email': email, 
      'password': password, 
      'isAdm': isAdm };


}