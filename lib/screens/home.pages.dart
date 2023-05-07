// ignore: depend_on_referenced_packages
import 'package:animations/animations.dart';
import 'package:travel/repositorie/film.data.dart';
import 'package:travel/screens/details.page.dart';
import 'package:travel/screens/new_film.page.dart'; // import de la nouvelle page
import 'package:flutter/material.dart';

import '../model/film.model.dart';
import 'table_users.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilmService filmService = FilmService();
  late List<Film> _films = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _films = [];
    _searchController = TextEditingController();
    fetchFilms(); // récupération des films depuis la base de données
  }

  void fetchFilms() async {
    List<Film> fetchedFilms = filmService.allFilms();
    setState(() {
      _films = fetchedFilms;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Film> _getFilteredFilms(String query) {
    if (query.isEmpty) {
      return _films;
    } else {
      return _films
          .where((film) =>
              film.titre.toLowerCase().contains(query.toLowerCase()) ||
              film.directeur.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType transition = ContainerTransitionType.fadeThrough;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Films"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserTable()),
                );
              },
              child: const Text('Go to Admin Page'),
            ),
            Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: ' Search by Name or Director',
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: _getFilteredFilms(_searchController.text).length,
                  itemBuilder: (BuildContext context, int index) {
                    final Film film =
                        _getFilteredFilms(_searchController.text)[index];
                    {
                      return OpenContainer(
                          transitionType: transition,
                          transitionDuration: const Duration(seconds: 1),
                          closedBuilder: (context, action) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/${_films[index].image}'),
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          openBuilder: (context, action) {
                            return DetailsPage(
                                titre: _films[index].titre,
                                synop: _films[index].synop,
                                directeur: _films[index].directeur,
                                image: _films[index].image);
                          });
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
// Naviguer vers la page d'ajout de film
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewFilmPage()));
          if (result != null && result) {
            fetchFilms(); // récupération des films après ajout
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
