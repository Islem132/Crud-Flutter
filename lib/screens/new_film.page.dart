import 'package:flutter/material.dart';
import 'package:travel/repositorie/film.data.dart';
import '../model/film.model.dart';
import 'dart:convert';
import 'package:travel/screens/home.pages.dart';

class NewFilmPage extends StatefulWidget {
  const NewFilmPage({Key? key}) : super(key: key);

  @override
  _NewFilmPageState createState() => _NewFilmPageState();
}

class _NewFilmPageState extends State<NewFilmPage> {
  final _formKey = GlobalKey<FormState>();

  String? _titre;
  String? _synop;
  String? _directeur;
  String? _image;
  void ajoutFilm(String titre, String synop, String directeur, String image) {
    final film =
        Film(titre: titre, directeur: directeur, synop: synop, image: image);
    FilmService fs = FilmService();
    fs.addFilm(film);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Titre du film',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titre = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Synopsis',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un synopsis';
                  }
                  return null;
                },
                onSaved: (value) {
                  _synop = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Directeur',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un directeur';
                  }
                  return null;
                },
                onSaved: (value) {
                  _directeur = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Image (chemin relatif)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une image';
                  }
                  return null;
                },
                onSaved: (value) {
                  _image = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ajoutFilm(_titre!, _synop!, _directeur!, _image!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
