import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kototinder/data/models/cat_model.dart';
import '../../data/services/cat_api_service.dart';
import '../../data/services/cat_like_service.dart';

part 'cat_card_state.dart';

class CatCardCubit extends Cubit<CatCardState> {
  final CatApiService _catApiService;
  final CatLikeService _catLikeService;

  CatCardCubit(this._catApiService, this._catLikeService)
      : super(const CatCardState()) {
    _catLikeService.likeCount.addListener(_updateLikeCount);
    loadNewCat();
  }

  void _updateLikeCount() {
    emit(state.copyWith(likeCount: _catLikeService.likeCount.value));
  }

  Future<void> loadNewCat() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final cat = await _catApiService.getRandomCat();
      if (cat != null) {
        emit(state.copyWith(
          currentCat: cat,
          isLoading: false,
          dragOffset: 0.0,
        ));
      } else {
        emit(state.copyWith(
          currentCat: null,
          isLoading: false,
          dragOffset: 0.0,
          errorMessage: 'Could not upload a cat with a breed.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        currentCat: null,
        isLoading: false,
        dragOffset: 0.0,
        errorMessage: 'An error occurred when loading the cat.',
      ));
    }
  }

  void likeCat() {
    if (state.currentCat != null) {
      _catLikeService.likeCat(state.currentCat!);
      emit(state.copyWith(dragOffset: 0.0));
    }
    loadNewCat();
  }

  void dislikeCat() {
    emit(state.copyWith(dragOffset: 0.0));
    loadNewCat();
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void cancelLoading() {}

  @override
  Future<void> close() {
    _catLikeService.likeCount.removeListener(_updateLikeCount);
    return super.close();
  }
}
