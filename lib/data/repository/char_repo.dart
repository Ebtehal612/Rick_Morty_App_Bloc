import '../models/character/character.dart';
import '../web_services/char_web.dart';

class CharRepo {
  final CharWeb charWeb;

  CharRepo(this.charWeb);

  Future<List<Character>> getAllChar() async {
    final characters = await charWeb.getAllChar();
    return (characters['results'] as List<dynamic>).map((character) {
      return Character.fromJson(character);
    }).toList();
  }
}
