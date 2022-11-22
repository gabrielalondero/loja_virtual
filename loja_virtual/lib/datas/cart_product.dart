import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct{
  String? cid; //cardId
  
  String? category;
  String? pid; //productId

  int? quantity;
  String? size;

  ProductData? productData;


  //construtuor vazio
  CartProduct();
  //construtor
  //esse documento será todos os produtos que estarão armazenados no carrinho
  //vai receber e tranformar cada produto em um CartProduct
  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.id;
    category = document.get('category');
    pid = document.get('pid');
    quantity = document.get('quantity');
    size = document.get('size');
  }

  //pega o objeto e tranforma em mapa para armazaenar no Firebase
  Map<String, dynamic> toMap(){
    return {
      'category' : category,
      'pid' : pid,
      'quantity' : quantity,
      'size' : size,
      'product' : productData!.toResumeMap()//guarda apenas o resumo dos produtos adicionados
    };
  }

  
}