import 'package:equatable/equatable.dart';

class DifficultyLevelsEntity extends Equatable {
  final String? id;
  final String? name;

  const DifficultyLevelsEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
