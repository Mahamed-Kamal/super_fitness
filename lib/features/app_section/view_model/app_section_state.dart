import 'package:equatable/equatable.dart';

class AppSectionState extends Equatable {
  const AppSectionState({required this.currentIndex});

  final int currentIndex;

  AppSectionState copyWith({int? currentIndex}) {
    return AppSectionState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
