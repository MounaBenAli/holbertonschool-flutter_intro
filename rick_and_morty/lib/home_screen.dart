import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  Future<List<Character>> fetchBbCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final characters = (jsonData['results'] as List<dynamic>)
          .map((characterData) => Character.fromJson(characterData))
          .toList();
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: FutureBuilder<List<Character>>(
        future: fetchBbCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final characters = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return Column(
                  children: [
                    Image.network(
                      character.img,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                    Text(character.name),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
