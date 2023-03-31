import 'package:flutter/material.dart';
import 'package:rick_and_morty/models.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      // ignore: sort_child_properties_last
      child: Image.network(
        character.img,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title: Text(character.name),
      ),
    );
  }
}
