import 'package:equatable/equatable.dart';

class MusclesResponseEntity extends Equatable {
  final List<MusclesEntity>? muscles;

  const MusclesResponseEntity({this.muscles});

  @override
  List<Object?> get props => [muscles];
}

class MusclesEntity extends Equatable {
  final String? id;
  final String? image;
  final String? name;
  const MusclesEntity({required this.id, this.image, this.name});

  @override
  List<Object?> get props => [id, image, name];
}

class MusclesGroupResponseEntity extends Equatable {
  final List<MusclesGroupEntity>? musclesGroup;

  const MusclesGroupResponseEntity({required this.musclesGroup});
  @override
  List<Object?> get props => [musclesGroup];
}

class MusclesGroupEntity extends Equatable {
  final String? id;
  final String? name;
  const MusclesGroupEntity({required this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
