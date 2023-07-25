import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(RickMorty(
    appRouter: AppRouter(),
  ));
}

class RickMorty extends StatelessWidget {
  final AppRouter appRouter;

  const RickMorty({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
