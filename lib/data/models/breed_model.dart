import '../../domain/entities/breed.dart';

class BreedModel extends Breed {
  BreedModel({
    super.id,
    super.name,
    super.description,
    super.temperament,
    super.origin,
    super.lifeSpan,
    super.wikipediaUrl,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      temperament: json['temperament'],
      origin: json['origin'],
      lifeSpan: json['life_span'],
      wikipediaUrl: json['wikipedia_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'temperament': temperament,
      'origin': origin,
      'life_span': lifeSpan,
      'wikipedia_url': wikipediaUrl,
    };
  }
}
