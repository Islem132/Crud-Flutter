import 'package:travel/model/film.model.dart';

class FilmService {
  List<Map<String, dynamic>> data = [
    {
      "titre": "Le prestige",
      "synopsis":
          "Après un tragique accident, deux magiciens se lancent dans un combat pour créer l'illusion ultime en sacrifiant tout ce qu'ils ont pour déjouer les tours de l'autre.",
      "directeur": "Christopher Nolan",
      "image": "1.jpg"
    },
    {
      "titre": "Batman Begins",
      "synopsis":
          "Après s'être entrainé avec son mentor, Batman commence son combat pour libérer la ville de Gotham, une ville ravagée par le crime.",
      "directeur": "Christopher Nolan",
      "image": "2.jpg"
    },
    {
      "titre": "Hostiles",
      "synopsis":
          "En 1892, un légendaire capitaine d'armée accepte à contrecoeur d'escorter un chef Cheyenne et sa famille à travers un territoire dangereux.",
      "directeur": "Scott Cooper",
      "image": "3.jpg"
    },
    {
      "titre": "Le Mans '66",
      "synopsis":
          "L'histoire vraie entre Ford et Ferrari pour gagner la course du Mans en 1966.",
      "directeur": "James Mangold",
      "image": "4.jpg"
    },
    {
      "titre": "État d'esprit",
      "synopsis":
          "Récemment divorcé, Greg, dont la vie va à vau-l'eau, rencontre la délicieuse Isabel, une femme vivant dans la rue, convaincue que le monde brisé et pollué autour d'eux n'est pas réel. Elle est persuadée qu'ils vivent dans une simulation laide et et rude à l'intérieur d'un autre vrai monde, beau et en paix.",
      "directeur": " Mike Cahill ",
      "image": "5.jpg"
    },
    {
      "titre": "SCANDALE",
      "synopsis":
          "Inspiré de faits réels, SCANDALE nous plonge dans les coulisses d’une chaîne de télévision aussi puissante que controversée. Des premières étincelles à l’explosion médiatique, découvrez comment des femmes journalistes ont réussi à briser la loi du silence pour dénoncer l’inacceptable.",
      "directeur": "Charles Randolph",
      "image": "6.jpg"
    },
  ];

  List<Film> allFilms() {
    return data.map((f) => Film.fromJson(f)).toList();
  }

  void addFilm(Film film) {
    print(film.toJson());
// Ajouter le film à la liste des données
    data.add(film.toJson());
  }

  List<Map<String, dynamic>> getAllFilms() {
    return data;
  }

  updateFilm(Film film) {}
}
