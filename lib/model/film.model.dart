class Film {
  String titre;
  String synop;
  String directeur;
  String image;

  Film({
    required this.titre,
    required this.synop,
    required this.directeur,
    required this.image,
  });

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'synopsis': synop,
      'directeur': directeur,
      'image': image,
    };
  }

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      titre: json['titre'],
      synop: json['synopsis'],
      directeur: json['directeur'],
      image: json['image'],
    );
  }
}
