// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source/auth_data_source_impl.dart'
    as _i985;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/use_cases/forgot_password_use_case.dart'
    as _i897;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i169;
import '../../features/auth/domain/use_cases/verify_reset_code_use_case.dart'
    as _i449;
import '../../features/auth/presentation/forget_password/view_model/forget_password_view_model.dart'
    as _i346;
import '../../features/auth/presentation/login/view_model/login_view_model.dart'
    as _i671;
import '../../features/auth/presentation/register/view_model/register_view_model.dart'
    as _i721;
import '../../features/exercises/data/data_sources/exercises_data_source.dart'
    as _i332;
import '../../features/exercises/data/data_sources/exercises_data_source_impl.dart'
    as _i414;
import '../../features/exercises/data/repo/exercises_repo_impl.dart' as _i78;
import '../../features/exercises/domain/repo/exercises_repo.dart' as _i335;
import '../../features/exercises/domain/use_case/get_difficulty_levels_use_case.dart'
    as _i750;
import '../../features/exercises/domain/use_case/get_exercises_use_case.dart'
    as _i676;
import '../../features/exercises/presentation/view_model/exercises_view_model.dart'
    as _i660;
import '../../features/meals/api/client/meals_api_client.dart' as _i293;
import '../../features/meals/api/di/meals_api_module.dart' as _i819;
import '../../features/meals/data/data_source/meals_remote_data_source.dart'
    as _i789;
import '../../features/meals/data/data_source/meals_remote_data_source_impl.dart'
    as _i700;
import '../../features/meals/data/repo/meals_repo_impl.dart' as _i783;
import '../../features/meals/domain/repo/meals_repo.dart' as _i749;
import '../../features/meals/domain/use_cases/get_meal_details_use_case.dart'
    as _i514;
import '../../features/meals/domain/use_cases/get_meals_by_category_use_case.dart'
    as _i385;
import '../../features/meals/domain/use_cases/get_meals_categories_use_case.dart'
    as _i1032;
import '../../features/meals/presentation/meals/view_model/meals_view_model.dart'
    as _i409;
import '../../features/workouts/data/data_source/workouts_data_source.dart'
    as _i233;
import '../../features/workouts/data/data_source/workouts_data_source_impl.dart'
    as _i312;
import '../../features/workouts/data/repo/workouts_repo_impl.dart' as _i187;
import '../../features/workouts/domain/repo/workouts_repo.dart' as _i301;
import '../../features/workouts/domain/use_cases/get_all_muscles_by_muscles_groups_use_case.dart'
    as _i803;
import '../../features/workouts/domain/use_cases/get_all_muscles_groups_use_case.dart'
    as _i302;
import '../../features/workouts/presentation/view_model/workouts_cubit.dart'
    as _i404;
import '../api/api_client.dart' as _i277;
import 'modules/remote_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    final mealsApiModule = _$MealsApiModule();
    gh.factory<_i514.GetMealDetailsUseCase>(
      () => _i514.GetMealDetailsUseCase(),
    );
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => apiModule.provideLogger());
    await gh.lazySingletonAsync<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i332.ExercisesDataSource>(
      () => _i414.ExercisesDataSourceImpl(gh<_i277.ApiClient>()),
    gh.lazySingleton<_i293.MealsApiClient>(
      () => mealsApiModule.provideMealsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i332.ExercisesDataSource>(
      () => _i414.ExercisesDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i233.WorkoutsDataSource>(
      () => _i312.WorkoutsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i364.AuthDataSource>(
      () => _i985.AuthDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i789.MealsRemoteDataSource>(
      () => _i700.MealsRemoteDataSourceImpl(gh<_i293.MealsApiClient>()),
    );
    gh.factory<_i335.ExercisesRepo>(
      () => _i78.ExercisesRepoImpl(gh<_i332.ExercisesDataSource>()),
    );
    gh.factory<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(gh<_i364.AuthDataSource>()),
    );
    gh.factory<_i301.WorkoutsRepo>(
      () => _i187.WorkoutsRepoImpl(gh<_i233.WorkoutsDataSource>()),
    );
    gh.factory<_i749.MealsRepo>(
      () => _i783.MealsRepoImpl(gh<_i789.MealsRemoteDataSource>()),
    );
    gh.factory<_i803.GetAllMusclesByMusclesGroupsUseCase>(
      () => _i803.GetAllMusclesByMusclesGroupsUseCase(gh<_i301.WorkoutsRepo>()),
    );
    gh.factory<_i302.GetAllMusclesGroupsUseCase>(
      () => _i302.GetAllMusclesGroupsUseCase(gh<_i301.WorkoutsRepo>()),
    );
    gh.factory<_i404.WorkoutsCubit>(
      () => _i404.WorkoutsCubit(
        gh<_i803.GetAllMusclesByMusclesGroupsUseCase>(),
        gh<_i302.GetAllMusclesGroupsUseCase>(),
      ),
    );
    gh.factory<_i750.GetDifficultyLevelsUseCase>(
      () => _i750.GetDifficultyLevelsUseCase(gh<_i335.ExercisesRepo>()),
    );
    gh.factory<_i676.GetExercisesUseCase>(
      () => _i676.GetExercisesUseCase(gh<_i335.ExercisesRepo>()),
    );
    gh.factory<_i897.ForgetPasswordUseCase>(
      () => _i897.ForgetPasswordUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i169.ResetPasswordUseCase>(
      () => _i169.ResetPasswordUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i449.VerifyResetCodeUseCase>(
      () => _i449.VerifyResetCodeUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i721.RegisterViewModel>(
      () => _i721.RegisterViewModel(gh<_i1010.RegisterUseCase>()),
    );
    gh.lazySingleton<_i346.ForgetPasswordViewModel>(
      () => _i346.ForgetPasswordViewModel(
        gh<_i897.ForgetPasswordUseCase>(),
        gh<_i449.VerifyResetCodeUseCase>(),
        gh<_i169.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i671.LoginViewModel>(
      () => _i671.LoginViewModel(gh<_i1038.LoginUseCase>()),
    );
    gh.factory<_i385.GetMealsByCategoryUseCase>(
      () => _i385.GetMealsByCategoryUseCase(gh<_i749.MealsRepo>()),
    );
    gh.factory<_i1032.GetMealsCategoriesUseCase>(
      () => _i1032.GetMealsCategoriesUseCase(gh<_i749.MealsRepo>()),
    );
    gh.factory<_i409.MealsViewModel>(
      () => _i409.MealsViewModel(
        gh<_i1032.GetMealsCategoriesUseCase>(),
        gh<_i385.GetMealsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i660.ExercisesViewModel>(
      () => _i660.ExercisesViewModel(
        gh<_i750.GetDifficultyLevelsUseCase>(),
        gh<_i676.GetExercisesUseCase>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i616.ApiModule {}

class _$MealsApiModule extends _i819.MealsApiModule {}
