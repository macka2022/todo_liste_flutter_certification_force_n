// ignore: file_names
import 'package:flutter/material.dart';
import 'package:organiser/Detailstaches.dart';
import 'package:organiser/Variables/liste.dart';

class Lister extends StatefulWidget {
  const Lister({super.key});

  @override
  State<Lister> createState() {
    return Etatlister();
  }
}

class Etatlister extends State<Lister> {
  
  List<Map<String, dynamic>> filtre=[];
  final trier=TextEditingController();

 
@override
  void initState(){
  super.initState();
  filtre=listes.taches;
}

void filtrerList(String query){
  setState(() {
    if(query.isEmpty){
      filtre=listes.taches;
    }
    else{
      filtre=listes.taches.where((taches)=>taches["Titre"].toLowerCase().contains(query.toLowerCase())).toList();
    }
  });
}






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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 3,
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset('assets/images/Efforts.jpg', fit: BoxFit.fill),
          ),
          SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BoxBorder.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: trier,
                    onChanged: filtrerList,
                    showCursor: false,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(Icons.search),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 30,
                    //width: MediaQuery.of(context).size.width*0.28,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.push(context,
                        // MaterialPageRoute(
                        //   builder: (context){
                        //     return DetailsTask();
                        //   }
                        // ));
                      },
                      child: Text(
                        "Ajouter une tache",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0.5, color: Colors.red),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 211, 211),
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListView.builder(
                itemCount: filtre.length,
                itemBuilder: (context, index) {
                  Map tache = filtre[index];
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
                              tache["Titre"],
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
                                "${tache["Description"]?.split("").take(20).join("")}....",
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsTask(index: index);
                                    },
                                  ),
                                );
                              },
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
                                      color: tache["Couleur"],
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
                              tache["Date_heure"],
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

      // bottomNavigationBar: Container(
      //   height: MediaQuery.of(context).size.height*0.06,
      //   child: NavigationBar(
      //     backgroundColor: Colors.brown,
      //     destinations:[
      //       Icon(Icons.crop_square,color: Colors.white),
      //       Icon(Icons.pause_circle_filled_outlined,color: Colors.white),
      //       Icon(Icons.play_arrow,
      //       textDirection: TextDirection.rtl,color: Colors.white)
      //     ],
      //   ),
      // ),
    );
  }
}
