import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'movies_container.dart';

Future<List<Container>?> getTrending(BuildContext context) async {
  var uri = Uri.parse(
      'https://api.themoviedb.org/3/trending/all/day?api_key=9e6dcf9b5b81eb0a6dca49ee9937b177');
  final response = await http.get(uri);
  final body = jsonDecode(response.body);
  List<Container> temp = [];
  for (int i = 0; i < body['results'].length; i++) {
    temp.add(
      movieContainer(
          body['results'][i]['title'],
          'https://image.tmdb.org/t/p/original/wigZBAmNrIhxp2FNGOROUAeHvdh.jpg',
          context),
    );
    return temp;
  }
}
