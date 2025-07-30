import 'package:tea_list/features/auth/domain/repository/email_auth_repository.dart';
import 'package:tea_list/features/auth/domain/repository/google_auth_repository.dart';

abstract class AuthRepository implements EmailAuthRepository, GoogleAuthRepository {}
