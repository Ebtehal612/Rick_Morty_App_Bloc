import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/cubit/char_cubit.dart';
import 'consts/strings.dart';
import 'data/models/character/character.dart';
import 'data/repository/char_repo.dart';
import 'data/web_services/char_web.dart';
import 'presentation/screen/char_details.dart';
import 'presentation/screen/char_screen.dart';

class AppRouter {
  late CharRepo charRepo;
  late CharCubit charCubit;
  AppRouter() {
    charRepo = CharRepo(CharWeb());
    charCubit = CharCubit(charRepo);
  }
  // ignore: body_might_complete_normally_nullable
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allcharacterscreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharCubit(charRepo),
            child: const Characterscreen(),
          ),
        );
      case charDetail:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharDetails(
                  character: character,
                ));
    }
    // return null;
  }
}
