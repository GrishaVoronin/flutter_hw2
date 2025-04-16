import 'breed.dart';

class Cat {
  final String id;
  final String? url;
  final List<Breed>? breeds;

  Cat({required this.id, this.url, this.breeds});
}
