import '../../domain/entities/cat.dart';
import 'breed_model.dart';

class CatModel extends Cat {
  CatModel({
    required super.id,
    super.url,
    super.breeds,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] ?? '',
      url: json['url'],
      breeds: json['breeds'] != null
          ? (json['breeds'] as List).map((b) => BreedModel.fromJson(b)).toList()
          : null,
    );
  }
}
