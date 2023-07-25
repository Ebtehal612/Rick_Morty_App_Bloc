import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repository/char_repo.dart';
import '../../../data/models/character/character.dart';

part 'char_state.dart';

class CharCubit extends Cubit<Characterstate> {
  final CharRepo charRepo;
  List<Character> characters = [];
  CharCubit(this.charRepo) : super(CharInitial());

  List<Character> getAllChar() {
    charRepo.getAllChar().then((characters) {
      emit(CharLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
