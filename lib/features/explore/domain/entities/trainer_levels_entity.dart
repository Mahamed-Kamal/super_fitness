import 'package:equatable/equatable.dart';

class TrainerLevelsEntity extends Equatable {
  final List<LevelEntity> levels;

  const TrainerLevelsEntity({required this.levels});
  @override
  List<Object?> get props => [levels];
}

class LevelEntity extends Equatable {
  final String? id;
  final String? name;
  const LevelEntity({this.id, this.name});
  @override
  List<Object?> get props => [id, name];
}
