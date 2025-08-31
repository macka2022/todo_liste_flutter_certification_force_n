import 'package:flutter/material.dart';

class Lister extends StatefulWidget {
  const Lister({super.key});

  @override
  State<Lister> createState() {
    return Etatlister();
  }
}

class Etatlister extends State<Lister> {
  final List<Map<String, dynamic>> taches = [
    {
      "Titre": "Faire du Java",
      "Description": "Le java est un langage de programmation",
      "Date_heure": "21/09/2025 a 07:00 min",
      "Elevation": "eleve",
      "Couleur": const Color.fromARGB(255, 240, 31, 16),
    },
    {
      "Titre": "Faire du Dart",
      "Description": "Le Dart est un langage de programmation oriente objet",
      "Date_heure": "21/09/2025 a 11:30 min",
      "Elevation": "Moyenne",
      "Couleur":  const Color.fromARGB(255, 170, 78, 71),
    },
    {
      "Titre": "Faire du Python",
      "Description": "Le java est un langage de programmation oriente objet non type",
      "Date_heure": "01/10/2025 a 10:00 min",
      "Elevation": "Basse",
      "Couleur":  const Color.fromARGB(255, 240, 168, 163),
    },
    {
      "Titre": "Faire du Python",
      "Description": "Le java est un langage de programmation oriente objet non type",
      "Date_heure": "01/10/2025 a 10:00 min",
      "Elevation": "Basse",
      "Couleur":  const Color.fromARGB(255, 240, 168, 163),
    },
    {
      "Titre": "Faire du Python",
      "Description": "Le java est un langage de programmation oriente objet non type",
      "Date_heure": "01/10/2025 a 10:00 min",
      "Elevation": "Basse",
      "Couleur":  const Color.fromARGB(255, 240, 168, 163),
    },
    {
      "Titre": "Faire du Python",
      "Description": "Le java est un langage de programmation oriente objet non type",
      "Date_heure": "01/10/2025 a 10:00 min",
      "Elevation": "Basse",
      "Couleur":  const Color.fromARGB(255, 240, 168, 163),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 222, 222),
        leading: Icon(Icons.menu, color: Colors.black),
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.79,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
            ),
            child: Center(
              child: Text(
                "Liste des taches programmees",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 3,
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset('assets/images/Efforts.jpg', fit: BoxFit.fill),
          ),
          Divider(height: 0.5, color: Colors.red),
          // SizedBox(height:1),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 211, 211),
                borderRadius: BorderRadius.circular(5),
              ),

              child: ListView.builder(
                itemCount: taches.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    padding: EdgeInsets.only(left: 3),
                    width: MediaQuery.of(context).size.width * 0.75,
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: BoxBorder.all(color: Colors.black),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //spacing: 2,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                              taches[index]["Titre"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Text(
                                "${taches[index]["Description"]?.split("").take(20).join("")}....",
                              ),
                              onPressed: () {},
                            ),
                            //  SizedBox(
                            //   width: 2,
                            // ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        const Color.fromARGB(
                                          255,
                                          218,
                                          208,
                                          208,
                                        ),
                                      ),
                                    ),
                                    alignment: AlignmentGeometry.center,
                                    iconSize: 13,
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      //size: 16,
                                    ),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.person_add_alt,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 7),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: taches[index]["Couleur"],
                                      //const Color.fromARGB(
                                      //   255,
                                      //   135,
                                      //   79,
                                      //   231,
                                      // )
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.priority_high, size: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              taches[index]["Date_heure"],
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
