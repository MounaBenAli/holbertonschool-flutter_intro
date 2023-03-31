import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EpisodesScreen extends StatelessWidget {
  final int id;

  const EpisodesScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  Future<List<String>> fetchEpisodes(int id) async {
    final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/episode'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final episodes = List<Map<String, dynamic>>.from(data['results']);
      final characterUrl = 'https://rickandmortyapi.com/api/character/$id';
      final episodesCharacter = <String>[];
      for (final episode in episodes) {
        final listChara = List<String>.from(episode['characters']);
        if (listChara.contains(characterUrl)) {
          episodesCharacter.add(episode['name'].toString());
        }
      }

      return episodesCharacter;
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Rick and Morty Episodes"),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchEpisodes(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listEpisodes = snapshot.data!;
            return ListView.builder(
              itemCount: listEpisodes.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                  horizontalTitleGap: 0,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  title: Text(
                    '* ${listEpisodes[index]}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
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
