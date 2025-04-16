import '../../domain/entities/cat.dart';
import '../../domain/entities/breed.dart';

abstract class CatRepository {
  Future<Cat?> getRandomCat();
  Future<List<Cat>> getMultipleCats(int count);
  Future<List<Breed>> getBreeds();
}
