import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

import '../tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.snapshot});

  //documento vai indicar qual é o id e título da categoria
  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    //para mudas de tabs (em lista ou em grade)
    return DefaultTabController(
      length: 2, //numero de tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(snapshot.get('title')),
          centerTitle: true,
          bottom: const TabBar(indicatorColor: Colors.white, //cor da tab atual
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list)),
              ]),
        ),
        body: FutureBuilder<QuerySnapshot>(
          //recebendo todos os documentos da categoria itens
          future: FirebaseFirestore.instance
              .collection('products')
              .doc(snapshot.id)
              .collection('itens')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              //se não tem dados
              return const Center(child: CircularProgressIndicator());
            }
            //se tiver
            return TabBarView(
              //coloca o que quer ver em cada uma das tabs em ordem
              physics:
                  const NeverScrollableScrollPhysics(), //não poder arrastar para o lado
              children: [
                //.builder -> para ir carregando os dados na tela somente quando ir rolando
                GridView.builder(
                  padding: const EdgeInsets.all(4),
                  //gridDelegate controla o tamanho e a posição dos itens, quantos itens quer em cada eixo
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //2 itens na horizontal
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio:
                        0.65, //divisão da altura pela largura do item
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //passa cada documento atraves do index, tranforma em um objeto, passa para o ProductTile
                    ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                    data.category = this.snapshot.id;//passando a catergoria do documento(produto)
                    return ProductTile( 
                      type: 'grid',
                      product: data,
                    );
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                    data.category = this.snapshot.id;
                    return ProductTile(
                      type: 'list',
                      product: data,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
