import '../../domain/entities/breed.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../data/services/cat_api_service.dart';

class CatRepositoryImpl implements CatRepository {
  final CatApiService apiService;

  CatRepositoryImpl(this.apiService);

  @override
  Future<Cat?> getRandomCat() async {
    return await apiService.getRandomCat();
  }

  @override
  Future<List<Cat>> getMultipleCats(int count) async {
    return await apiService.getMultipleCats(count);
  }

  @override
  Future<List<Breed>> getBreeds() async {
    return await apiService.getBreeds();
  }
}
