import 'package:flutter/material.dart';
import 'package:organiser/Variables/liste.dart';

class DetailsTask extends StatefulWidget {
  final int index;

  const DetailsTask({super.key, required this.index});

  @override
  State<DetailsTask> createState() {
    return DetailsEtat();
  }
}

class DetailsEtat extends State<DetailsTask> {
  @override
  Widget build(BuildContext context) {
    final taches = listes.taches[widget.index];
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
                "Description de ''${taches["Titre"]}''",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        //centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 11),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 195, 240),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Center(
                child: Text("G", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(13),
        alignment: Alignment(0, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06820),

            
          Text(taches["Description"], style: TextStyle(fontSize: 12)),

            SizedBox(height: MediaQuery.of(context).size.height * 0.65),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text(
                    "Retour",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
