part of 'char_cubit.dart';

@immutable
abstract class Characterstate {}

class CharInitial extends Characterstate {}

class CharLoaded extends Characterstate {
  final List<Character> characters;

  CharLoaded(this.characters);
}
