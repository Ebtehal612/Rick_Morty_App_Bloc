import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../data/models/character/character.dart';

class CharDetails extends StatelessWidget {
  final Character character;
  const CharDetails({Key? key, required this.character}) : super(key: key);

  Widget bulidSliver() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.id!,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget charInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 16,
          ),
        )
      ]),
    );
  }

  Widget buidDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: Color.fromARGB(255, 79, 1, 79),
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGray,
      body: CustomScrollView(
        slivers: [
          bulidSliver(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    charInfo('Gender: ', character.gender!),
                    buidDivider(250),
                    charInfo('Status: ', character.status ?? "NO Status"),
                    buidDivider(255),
                    charInfo('Location: ',
                        character.location?.name ?? "No Location"),
                    buidDivider(240),
                    charInfo('Species: ', character.species!),
                    buidDivider(248),
                    charInfo(
                        'Origin: ', character.location?.name ?? "No Origin"),
                    buidDivider(259),
                    charInfo('Episode: ', getEpos()),
                    buidDivider(245),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
            ),
            const SizedBox(height: 500),
          ]))
        ],
      ),
    );
  }

  String getEpos() {
    String res = "";
    for (var epo in character.episode!) {
      var temp = "";
      int sz = epo.length;
      for (int i = sz - 1; i >= 0; i--) {
        if (epo[i] == '/') {
          break;
        }
        temp += epo[i];
      }
      temp = temp.split('').reversed.join('');
      res += temp;
      res += ', ';
    }
    return res;
  }
}
