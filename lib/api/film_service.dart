import 'dart:convert';
import 'package:travel/repositorie/film.data.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:travel/model/film.model.dart';

class FilmService {
  static const String baseUrl =
      'https://example.com/api/films'; // Remplacez "https://example.com/api/films" par l'URL de votre API

  Future<List<Film>> getAllFilms() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      return jsonData.map((film) => Film.fromJson(film)).toList();
    } else {
      throw Exception('Failed to load films');
    }
  }

  Future<Film> getFilmById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return Film.fromJson(jsonData);
    } else {
      throw Exception('Failed to load film');
    }
  }

  Future<void> addFilm(Film film) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(film.toJson()));
    if (response.statusCode != 201) {
      throw Exception('Failed to add film');
    }
  }

  Future<void> updateFilm(Film film) async {
    final response = await http.put(Uri.parse('$baseUrl/${film.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(film.toJson()));
    if (response.statusCode != 204) {
      throw Exception('Failed to update film');
    }
  }

  Future<void> deleteFilm(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete film');
    }
  }
}
