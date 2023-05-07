import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  String titre;
  String synop;
  String directeur;
  String image;

  DetailsPage(
      {required this.titre,
      required this.synop,
      required this.directeur,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$titre de $directeur'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(synop,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 2, 35, 61))),
            GestureDetector(
              child: Image.asset('assets/$image'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
