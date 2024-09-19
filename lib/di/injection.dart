import 'package:alice/alice.dart';
import 'package:get_it/get_it.dart';
import 'package:story_app/core/network.dart';
import 'package:story_app/pages/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:story_app/pages/authentication/data/repositories/auth_repository_impl.dart';
import 'package:story_app/pages/authentication/domain/repositories/auth_repository.dart';
import 'package:story_app/pages/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:story_app/pages/story/data/data_source/story_remote_data_source.dart';
import 'package:story_app/pages/story/data/repositories/story_repository_impl.dart';
import 'package:story_app/pages/story/domain/repositories/story_repository.dart';
import 'package:story_app/pages/story/domain/use_cases/story_use_case.dart';
import 'package:story_app/utils/alice.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
//presentation

  sl.registerSingleton<AliceSetup>(AliceSetup());
//data
  sl.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerFactory<StoryRemoteDataSource>(() => StoryRemoteDataSourceImpl());

//domain
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerFactory<AuthUseCase>(() => AuthUseCase());

  sl.registerFactory<StoryRepository>(() => StoryRepositoryImpl());
  sl.registerFactory<StoryUseCase>(() => StoryUseCase());

//extern

  sl.registerSingleton<Network>(Network());
}
