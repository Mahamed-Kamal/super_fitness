import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_state.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';

void main() {
  group('test chnage index of bottomNavBar', () {
    blocTest<AppSectionViewModel, AppSectionState>(
      'the initial state of AppSectionViewModel should be MyState',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.doIntent(0),
      expect: () {
        final myState = AppSectionState(currentIndex: 0);
        return [myState];
      },
    );
    blocTest<AppSectionViewModel, AppSectionState>(
      'emit state [0 to 1]',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.doIntent(1),
      expect: () {
        final myState = AppSectionState(currentIndex: 0);
        return [myState.copyWith(currentIndex: 1)];
      },
    );
    blocTest<AppSectionViewModel, AppSectionState>(
      'emit state [1 to 2]',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.doIntent(2),
      expect: () {
        final myState = AppSectionState(currentIndex: 1);
        return [myState.copyWith(currentIndex: 2)];
      },
    );
    blocTest<AppSectionViewModel, AppSectionState>(
      'emit state [2 to 3]',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.doIntent(3),
      expect: () {
        final myState = AppSectionState(currentIndex: 2);
        return [myState.copyWith(currentIndex: 3)];
      },
    );
  });
}
