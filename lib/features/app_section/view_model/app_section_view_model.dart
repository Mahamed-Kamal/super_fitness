import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_cubit.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_state.dart';

@singleton
class AppSectionViewModel extends BaseCubit<AppSectionState, int, void> {
  AppSectionViewModel() : super(const AppSectionState(currentIndex: 0));

  void _changeIndex(int index) {
    emit(AppSectionState(currentIndex: index));
  }

  @override
  void doIntent(int currentIndex) {
    _changeIndex(currentIndex);
  }
}
