import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:logger/logger.dart';

import '../../business_logic/cubit/cubit/char_cubit.dart';
import '../../consts/colors.dart';
import '../../data/models/character/character.dart';
import '../widget/char_item.dart';

class Characterscreen extends StatefulWidget {
  const Characterscreen({Key? key}) : super(key: key);
  @override
  _CharacterscreenState createState() => _CharacterscreenState();
}

class _CharacterscreenState extends State<Characterscreen> {
  late List<Character> allChar;
  late List<Character> searchedChars;
  bool _isSearch = false;
  final _searcheText = TextEditingController();
  Widget buildSearch() {
    return TextField(
        controller: _searcheText,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: 'Find a Character....',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            helperStyle: TextStyle(color: Colors.white, fontSize: 18)),
        style: const TextStyle(color: Colors.white, fontSize: 18),
        onChanged: (searchedChar) {
          {
            addSearchedToList(searchedChar);
          }
        });
  }

  bool isFound = true;
  void addSearchedToList(String searchedChar) {
    searchedChars = allChar
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedChar))
        .toList();
    Logger().d(searchedChar.isEmpty);
    if (searchedChar.isEmpty) {
      isFound = false;
    } else {
      isFound = true;
    }

    setState(() {});
  }

  Widget notFound() {
    return const Center(
      child: Text(
        "No results found",
        style: TextStyle(color: MyColors.myGray, fontSize: 18),
      ),
    );
  }

  List<Widget> _buildAppBar() {
    if (_isSearch) {
      return [
        IconButton(
            onPressed: () {
              _clearSearching();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ))
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearching() {
    _clearSearching;
    setState(() {
      _isSearch = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharCubit>(context).getAllChar();
  }

  void _clearSearching() {
    setState(() {
      _searcheText.clear();
    });
  }

  Widget buildBlocWedget() {
    return BlocBuilder<CharCubit, Characterstate>(builder: (context, state) {
      if (state is CharLoaded) {
        allChar = (state).characters;
        return buildLoadedWedget();
      } else {
        return showLoadIndecator();
      }
    });
  }

  Widget showLoadIndecator() {
    return const Center(
      child: CircularProgressIndicator(color: Color.fromARGB(255, 79, 1, 79)),
    );
  }

  Widget buildLoadedWedget() {
    return Container(
      color: MyColors.myGray,
      child: buildCharList(),
    );
  }

  Widget buildCharList() {
    return isFound
        ? GridView.builder(
            // if(Empty=false){
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),

            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _searcheText.text.isEmpty
                ? allChar.length
                : searchedChars.length,
            itemBuilder: (ctx, index) {
              return CharItem(
                character: _searcheText.text.isEmpty
                    ? allChar[index]
                    : searchedChars[index],
              );
            },
          )
        : notFound();
  }

  Widget _buildAppBarTitel() {
    return const Text(
      'Characters',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
            child: Text(
              'Check your connection!',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGray,
              ),
            ),
          ),
          Image.asset('assets/images/nointernet.jpg')
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 1, 79),
        leading: _isSearch
            ? const BackButton(
                color: Colors.white,
              )
            : Container(),
        title: _isSearch ? buildSearch() : _buildAppBarTitel(),
        actions: _buildAppBar(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWedget();
          } else {
            return buildNoInternet();
          }
        },
        child: showLoadIndecator(),
      ),
    );
  }
}
