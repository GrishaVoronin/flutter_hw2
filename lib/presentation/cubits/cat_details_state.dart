part of 'cat_details_cubit.dart';

abstract class CatDetailsState extends Equatable {
  const CatDetailsState();

  @override
  List<Object?> get props => [];
}

class CatDetailsLoaded extends CatDetailsState {
  final Cat cat;

  const CatDetailsLoaded(this.cat);

  @override
  List<Object?> get props => [cat];
}
