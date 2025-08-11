import 'package:tea_list/features/auth/data/models/user_model.dart';

class UserEntity extends UserModel {
  UserEntity({
    required super.name,
    required super.email,
    required super.password,
    required super.teas,
    required super.ceremonies,
  });
}
