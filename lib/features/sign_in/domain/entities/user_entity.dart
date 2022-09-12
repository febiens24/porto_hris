import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String status;
  final UserResultEntity? result;

  const UserEntity({
    required this.status,
    this.result,
  });

  @override
  List<Object?> get props => [
        status,
        result,
      ];
}

class UserResultEntity extends Equatable {
  final String userName;
  final String userType;
  final int userPartnerId;
  final String userPartnerImage;
  final String userPartnerEmail;
  final String userLogin;
  final String userPartnerPhone;
  final String userId;

  const UserResultEntity({
    required this.userName,
    required this.userType,
    required this.userPartnerId,
    required this.userPartnerImage,
    required this.userPartnerEmail,
    required this.userLogin,
    required this.userPartnerPhone,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userName,
        userType,
        userPartnerId,
        userPartnerImage,
        userPartnerEmail,
        userLogin,
        userPartnerPhone,
        userId,
      ];
}
