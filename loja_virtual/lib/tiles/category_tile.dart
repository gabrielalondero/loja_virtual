import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.snapshot});

  //pega o ducumento da categoria
  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading é a parte que fica no início
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.get('icon')),
      ),
      title: Text(snapshot.get('title')),
      //trailing é a parte que fica no fim
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        //vai para a tela CategoryScreen passando o snapshot (documento)
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot: snapshot)),
        );
      },
    );
  }
}
