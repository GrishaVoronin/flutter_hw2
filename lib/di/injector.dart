import 'package:get_it/get_it.dart';
import 'package:kototinder/data/models/cat_model.dart';
import 'package:kototinder/data/services/cat_like_service.dart';
import 'package:kototinder/presentation/cubits/liked_cats_cubit.dart';

import '../data/services/cat_api_service.dart';
import '../data/repositories/cat_repository_impl.dart';
import '../domain/repositories/cat_repository.dart';
import '../domain/usecases/get_random_cat.dart';
import '../presentation/cubits/cat_card_cubit.dart';
import '../presentation/cubits/cat_details_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => CatApiService());
  sl.registerLazySingleton(() => CatLikeService());
  sl.registerLazySingleton<CatRepository>(() => CatRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetRandomCatUseCase(sl()));

  sl.registerFactory(() => CatCardCubit(sl(), sl()));
  sl.registerFactory(() => LikedCatsCubit(sl()));

  sl.registerFactoryParam<CatDetailsCubit, CatModel, void>(
    (cat, _) => CatDetailsCubit(cat),
  );
}
