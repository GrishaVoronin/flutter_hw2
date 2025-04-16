import 'package:flutter/foundation.dart';
import '../../domain/entities/cat.dart';
import '../../domain/entities/liked_cat.dart';

class CatLikeService {
  final ValueNotifier<int> _likeCount = ValueNotifier(0);
  final List<LikedCat> _likedCats = [];

  ValueNotifier<int> get likeCount => _likeCount;
  List<LikedCat> get likedCats => _likedCats;

  void likeCat(Cat cat) {
    final likedCat = LikedCat(cat: cat, likedAt: DateTime.now());
    _likedCats.add(likedCat);
    _likeCount.value = _likedCats.length;
  }

  void unlikeCat(String id) {
    _likedCats.removeWhere((e) => e.cat.id == id);
    _likeCount.value = _likedCats.length;
  }

  void clearLikes() {
    _likedCats.clear();
    _likeCount.value = 0;
  }
}
