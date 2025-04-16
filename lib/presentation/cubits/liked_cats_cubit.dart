import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/cat_like_service.dart';
import '../../domain/entities/cat.dart';
import '../../domain/entities/liked_cat.dart';

part 'liked_cats_state.dart';

class LikedCatsCubit extends Cubit<LikedCatsState> {
  final CatLikeService _catLikeService;

  LikedCatsCubit(this._catLikeService) : super(LikedCatsInitial()) {
    loadAll();
  }

  void likeCat(Cat cat) {
    _catLikeService.likeCat(cat);
    emit(LikedCatsLoaded(List.from(_catLikeService.likedCats)));
  }

  void unlikeCat(String id) {
    _catLikeService.unlikeCat(id);
    emit(LikedCatsLoaded(List.from(_catLikeService.likedCats)));
  }

  void search(String query) {
    final filtered = _catLikeService.likedCats
        .where((e) =>
            e.cat.breeds?.first.name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false)
        .toList();
    emit(LikedCatsLoaded(filtered));
  }

  void resetSearch() {
    emit(LikedCatsLoaded(List.from(_catLikeService.likedCats)));
  }

  void loadAll() {
    emit(LikedCatsLoaded(List.from(_catLikeService.likedCats)));
  }

  List<String> getUniqueBreeds() {
    final breeds = _catLikeService.likedCats
        .map((e) => e.cat.breeds?.first.name ?? '')
        .toSet();
    return breeds.toList();
  }
}
