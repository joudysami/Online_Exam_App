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
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../feature/Auth/data/api/auth_api_client.dart' as _i39;
import '../../feature/Auth/data/datasource/local/auth_local_datasource.dart'
    as _i505;
import '../../feature/Auth/data/datasource/local/auth_local_datasource_impl.dart'
    as _i868;
import '../../feature/Auth/data/datasource/remote/auth_remote_datasource.dart'
    as _i345;
import '../../feature/Auth/data/datasource/remote/auth_remote_datasource_impl.dart'
    as _i242;
import '../../feature/Auth/data/repo/auth_repository_impl.dart' as _i716;
import '../../feature/Auth/domain/repo/auth_repository.dart' as _i847;
import '../../feature/Auth/domain/usecase/forget_password_usecase.dart'
    as _i486;
import '../../feature/Auth/domain/usecase/login_usecase.dart' as _i41;
import '../../feature/Auth/domain/usecase/reset_password_usecase.dart' as _i454;
import '../../feature/Auth/domain/usecase/sign_up_usecase.dart' as _i808;
import '../../feature/Auth/domain/usecase/verify_code_usecase.dart' as _i866;
import '../../feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart'
    as _i997;
import '../../feature/Auth/presentation/login/view_model/login_view_model.dart'
    as _i1000;
import '../../feature/Auth/presentation/sign_up/view_model/sign_up_view_model.dart'
    as _i735;
import '../../feature/Home/data/api/home_api_client.dart' as _i602;
import '../../feature/Home/data/data_source/remote/home_remote_datasource.dart'
    as _i546;
import '../../feature/Home/data/data_source/remote/home_remote_datasource_impl.dart'
    as _i82;
import '../../feature/Home/data/repo/home_repo_impl.dart' as _i585;
import '../../feature/Home/domain/repo/home_repo.dart' as _i440;
import '../../feature/Home/domain/usecase/subject_usecase.dart' as _i773;
import '../../feature/Home/presentation/view_model/home_view_model.dart'
    as _i413;
import '../modules/dio_module.dart' as _i948;
import '../network/auth_interceptors.dart' as _i466;
import '../network/safe_call.dart' as _i185;
import 'api_module.dart' as _i804;
import 'shared_pref_module.dart' as _i451;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefModule = _$SharedPrefModule();
    final dioModule = _$DioModule();
    final apiModule = _$ApiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.prefs,
      preResolve: true,
    );
    gh.factory<_i185.SafeCall>(() => _i185.SafeCall());
    gh.factory<_i466.AuthInterceptors>(
      () => _i466.AuthInterceptors(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i505.AuthLocalDatasource>(
      () => _i868.AuthLocalDatasourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i466.AuthInterceptors>()),
    );
    gh.lazySingleton<_i602.HomeApiClient>(
      () => apiModule.provideHomeApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i39.AuthApiClient>(
      () => apiModule.provideAuthApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i546.HomeRemoteDatasource>(
      () => _i82.HomeRemoteDatasourceImpl(gh<_i602.HomeApiClient>()),
    );
    gh.factory<_i345.AuthRemoteDatasource>(
      () => _i242.AuthRemoteDatasourceImpl(gh<_i39.AuthApiClient>()),
    );
    gh.factory<_i847.AuthRepository>(
      () => _i716.AuthRepositoryImpl(
        gh<_i345.AuthRemoteDatasource>(),
        gh<_i505.AuthLocalDatasource>(),
        gh<_i185.SafeCall>(),
      ),
    );
    gh.factory<_i440.HomeRepo>(
      () => _i585.HomeRepoImpl(
        gh<_i546.HomeRemoteDatasource>(),
        gh<_i185.SafeCall>(),
      ),
    );
    gh.factory<_i486.ForgetPasswordUseCase>(
      () => _i486.ForgetPasswordUseCase(gh<_i847.AuthRepository>()),
    );
    gh.factory<_i41.LoginUseCase>(
      () => _i41.LoginUseCase(gh<_i847.AuthRepository>()),
    );
    gh.factory<_i454.ResetPasswordUseCase>(
      () => _i454.ResetPasswordUseCase(gh<_i847.AuthRepository>()),
    );
    gh.factory<_i808.SignUpUseCase>(
      () => _i808.SignUpUseCase(gh<_i847.AuthRepository>()),
    );
    gh.factory<_i866.VerifyCodeUseCase>(
      () => _i866.VerifyCodeUseCase(gh<_i847.AuthRepository>()),
    );
    gh.factory<_i773.SubjectUseCase>(
      () => _i773.SubjectUseCase(gh<_i440.HomeRepo>()),
    );
    gh.factory<_i735.SignUpViewModel>(
      () => _i735.SignUpViewModel(gh<_i808.SignUpUseCase>()),
    );
    gh.factory<_i413.HomeViewModel>(
      () => _i413.HomeViewModel(gh<_i773.SubjectUseCase>()),
    );
    gh.factory<_i1000.LoginViewModel>(
      () => _i1000.LoginViewModel(gh<_i41.LoginUseCase>()),
    );
    gh.factory<_i997.ForgetPasswordViewModel>(
      () => _i997.ForgetPasswordViewModel(
        gh<_i486.ForgetPasswordUseCase>(),
        gh<_i866.VerifyCodeUseCase>(),
        gh<_i454.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPrefModule extends _i451.SharedPrefModule {}

class _$DioModule extends _i948.DioModule {}

class _$ApiModule extends _i804.ApiModule {}
