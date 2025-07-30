// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:tea_list/core/models/tea_model.dart';

class UserModel {
  String? name;
  String email;
  String password;
  List<TeaModel> teas;

  UserModel({this.name, required this.email, required this.password, required this.teas});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'teas': teas.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
      teas: List<TeaModel>.from(
        (map['teas'] as List<dynamic>).map<TeaModel>((x) => TeaModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }
}
