import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';

part 'cat_details_state.dart';

class CatDetailsCubit extends Cubit<CatDetailsState> {
  CatDetailsCubit(Cat cat) : super(CatDetailsLoaded(cat));
}
