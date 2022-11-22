
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  
  String? category;
  String? id;
  
  String? title;
  String? description;
  
  double? price;
  
  List? images;
  List? sizes;

  //pegando documento e transformando nos dados da classe
  //construtor
  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    price = snapshot.get('price') + 0.0;
    images = snapshot.get('images');
    sizes = snapshot.get('sizes');

  }

//resumo dos produtos - visto nos pedidos/carrinho
  Map<String, dynamic> toResumeMap(){
    return{
      'title' : title,
      'description' : description,
      'price' : price
    };
  }

  
}