// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  //built at 02:12:57
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String type;
  final String token;
  final List<Map<String, dynamic>> cart;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id, // This is supposed to be '_id' and not 'id'
      'name': name,
      'password': password,
      'email': email,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? 'user',
      token: map['token'] ?? '',
      cart:
          map['cart'] != null
              ? List<Map<String, dynamic>>.from(
                map['cart'].map((x) => Map<String, dynamic>.from(x)),
              )
              : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? type,
    String? token,
    List<Map<String, dynamic>>? cart,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
