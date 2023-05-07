import 'package:flutter/material.dart';
import 'package:travel/model/film.model.dart';
import 'package:travel/service/film_service.dart';

import '../repositorie/film.data.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  final FilmService _filmService = FilmService();
  List<Film> _films = [];

  @override
  void initState() {
    super.initState();
    _loadFilms();
  }

  Future<List<Map<String, dynamic>>> _loadFilms() async {
    final List<Map<String, dynamic>> films = await _filmService.getAllFilms();
    return films;
  }

  Future<void> _addFilm(Film film) async {
    _filmService.addFilm(film);
    _loadFilms();
  }

  Future<void> _updateFilm(Film film) async {
    await _filmService.updateFilm(film);
    _loadFilms();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
