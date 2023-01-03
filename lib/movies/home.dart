import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login_screen.dart';

import 'movies_container.dart';

List<Container> _trending = [];
List<Container> _nowPlaying = [];
List<Container> _topRated = [];

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final String apiKey = '9e6dcf9b5b81eb0a6dca49ee9937b177';

  void getData() async {
    //Getting Trending data->
    http.Response trending = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/all/day?api_key=9e6dcf9b5b81eb0a6dca49ee9937b177'),
    );
    String baseURL = 'https://image.tmdb.org/t/p/original';
    final body = jsonDecode(trending.body);

    for (int i = 0; i < body['results'].length; i++) {
      _trending.add(
        movieContainer(
            body['results'][i]['title'].toString() == 'null'
                ? body['results'][i]['name'].toString()
                : body['results'][i]['title'].toString(),
            baseURL + body['results'][i]['poster_path'].toString(),
            context),
      );
    }
    //Getting nowPlaying data
    http.Response nowPlay = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=9e6dcf9b5b81eb0a6dca49ee9937b177&language=en-US&page=1'),
    );

    final body2 = jsonDecode(nowPlay.body);

    for (int i = 0; i < body2['results'].length; i++) {
      _nowPlaying.add(
        movieContainer(
            body2['results'][i]['original_title'].toString() == null
                ? body2['results'][i]['name'].toString()
                : body2['results'][i]['title'].toString(),
            baseURL + body2['results'][i]['poster_path'].toString(),
            context),
      );
    }

    //Getting top rated data
    http.Response trend = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=9e6dcf9b5b81eb0a6dca49ee9937b177&language=en-US&page=1'),
    );

    final body3 = jsonDecode(trend.body);

    for (int i = 0; i < body3['results'].length; i++) {
      _topRated.add(
        movieContainer(
            body3['results'][i]['original_title'].toString() == null
                ? body3['results'][i]['name'].toString()
                : body3['results'][i]['title'].toString(),
            baseURL + body3['results'][i]['poster_path'].toString(),
            context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<Widget> hello = [
      movieContainer(
          'hello',
          'https://image.tmdb.org/t/p/original/wigZBAmNrIhxp2FNGOROUAeHvdh.jpg',
          context)
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  enableSuggestions: true,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 20),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print('Signed Out');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => loginScreen(),
                            ),
                          );
                        });
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colors.white70,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        //link to page search.dart
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                    ),
                    labelText: 'What\' New',
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  keyboardType: false
                      ? TextInputType.visiblePassword
                      : TextInputType.text,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Trending Movies',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              //ListView 1
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _trending.length,
                  itemBuilder: ((context, index) => _trending[index]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                child: Text(
                  'Top Rated Movies',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              //ListView 2
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _topRated.length,
                  itemBuilder: ((context, index) => _topRated[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                child: Text(
                  'Now Playing',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              //ListView 3
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _nowPlaying.length,
                  itemBuilder: ((context, index) => _nowPlaying[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
