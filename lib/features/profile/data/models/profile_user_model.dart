import 'package:MatchIn/features/profile/domain/entities/profile_user_entity.dart';

class ProfileUserModel extends ProfileUserEntity {
  const ProfileUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.isActive,
    super.phone,
    super.avatar,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'candidate',
      isActive: json['is_active'] as bool? ?? true,
      phone: json['phone']?.toString(),
      avatar: json['avatar']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'is_active': isActive,
      'phone': phone,
      'avatar': avatar,
    };
  }
}
