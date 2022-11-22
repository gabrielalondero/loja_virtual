import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      //pegando as categorias da coleção produtos
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context ,snapshot){
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          //para dividir as tiles, pega as tiles, passa a cor e transforma em lista depois
          var dividedTiles = ListTile.divideTiles(
            //pega cada documento/ cada documento se torna um CategoryTile
            // transforma todos os CategoryTile em uma lista
            tiles: snapshot.data!.docs.map((doc){
              return CategoryTile(snapshot: doc);
            }).toList(),
            color: Colors.grey[500],
          ).toList(); 
          return ListView(
            children: dividedTiles,
          );
        }
      }
      
      );
  }
}