part of 'cat_card_cubit.dart';

class CatCardState extends Equatable {
  final CatModel? currentCat;
  final int likeCount;
  final bool isLoading;
  final double dragOffset;
  final String? errorMessage;

  const CatCardState({
    this.currentCat,
    this.likeCount = 0,
    this.isLoading = false,
    this.dragOffset = 0.0,
    this.errorMessage,
  });

  CatCardState copyWith({
    CatModel? currentCat,
    int? likeCount,
    bool? isLoading,
    double? dragOffset,
    String? errorMessage,
  }) {
    return CatCardState(
      currentCat: currentCat ?? this.currentCat,
      likeCount: likeCount ?? this.likeCount,
      isLoading: isLoading ?? this.isLoading,
      dragOffset: dragOffset ?? this.dragOffset,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentCat,
        likeCount,
        isLoading,
        dragOffset,
        errorMessage,
      ];
}
