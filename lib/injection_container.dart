// import 'package:flutter_session/flutter_session.dart';
import 'package:azure_test/core/features/accounts_list/presentation/bloc/accounts_list_bloc.dart';
import 'package:azure_test/core/features/auth/domain/usecases/get_user.dart';
import 'package:azure_test/core/features/auth/domain/usecases/logout.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/features/accounts_list/data/datasources/accounts_list_remote_data_source.dart';
import 'core/features/accounts_list/data/repositories/accounts_list_repository_impl.dart';
import 'core/features/accounts_list/domain/repositories/accounts_list_repository.dart';
import 'core/features/accounts_list/domain/usecases/accounts_list.dart';
import 'core/features/accounts_list/presentation/cubit/view/view_cubit.dart';
import 'core/features/auth/data/datasources/login_remote_data_source.dart';
import 'core/features/auth/data/repositories/login_repository_impl.dart';
import 'core/features/auth/domain/repositories/login_repository.dart';
import 'core/features/auth/domain/usecases/login.dart';
import 'core/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'shared/common/common.dart';
import 'shared/utils/http_client.dart';
import 'shared/utils/network/network_info.dart';

final inject = GetIt.instance;

Future<void> init() async {
  // BLoC
  inject.registerFactory(
      () => AuthBloc(getUser: inject(), login: inject(), logout: inject()));
  inject.registerFactory(() => AccountsListBloc(accounts_list: inject()));

  // Cubit
  inject.registerFactory(() => ViewCubit());

  // Use cases
  inject.registerLazySingleton(() => Login(inject()));
  inject.registerLazySingleton(() => Logout(inject()));
  inject.registerLazySingleton(() => GetUser(inject()));
  inject.registerLazySingleton(() => GetAccountsList(inject()));

  // Repository
  inject.registerLazySingleton<LoginRepository>(
    () =>
        LoginRepositoryImpl(remoteDataSource: inject(), networkInfo: inject()),
  );
  inject.registerLazySingleton<AccountsListRepository>(
    () => AccountsListRepositoryImpl(
        remoteDataSource: inject(), networkInfo: inject()),
  );

  // Data sources
  inject.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: inject(), preferences: inject()));
  inject.registerLazySingleton<AccountsListRemoteDataSource>(
      () => AccountsListRemoteDataSourceImpl(client: inject()));

  // Local
  final preferences = await SharedPreferences.getInstance();
  // final flutterSession = await FlutterSession();
  inject.registerLazySingleton(() => preferences);
  // inject.registerLazySingleton(() => flutterSession);
  inject.registerLazySingleton(() => NetworkInfo);
  inject.registerLazySingleton(() => Navigation());
  // inject.registerLazySingleton(() => SharedPrefHelper(preferences: inject(), flutterSession: inject()));
  inject.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(inject()));

  // Network
  inject.registerLazySingleton(() => HttpClient());
  inject.registerLazySingleton(() => DataConnectionChecker());
}
