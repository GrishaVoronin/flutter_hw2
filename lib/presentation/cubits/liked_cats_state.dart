part of 'liked_cats_cubit.dart';

abstract class LikedCatsState {}

class LikedCatsInitial extends LikedCatsState {}

class LikedCatsLoaded extends LikedCatsState {
  final List<LikedCat> cats;
  LikedCatsLoaded(this.cats);
}
