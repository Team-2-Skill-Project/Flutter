import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  const EducationEntity({
    required this.id,
    required this.degree,
    required this.institution,
    this.startDate,
    this.endDate,
    this.grade,
  });

  final int id;
  final String degree;
  final String institution;
  final String? startDate;
  final String? endDate;
  final String? grade;

  @override
  List<Object?> get props => [
    id,
    degree,
    institution,
    startDate,
    endDate,
    grade,
  ];
}
