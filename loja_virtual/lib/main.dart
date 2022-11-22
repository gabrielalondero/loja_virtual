import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/cart_model.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //tudo o que tiver abaixo do ScopedModel, vai ter acesso ao UserModel()
            //e vai ser modificado caso alguma coisa aconteça no UserModel()
            return ScopedModel<UserModel>(
              model: UserModel(),
              child: ScopedModelDescendant<UserModel>( //para que quando mude o usuário, mude o carrinho também
                builder: (context, child, model) {
                  return ScopedModel<CartModel>( //ScopedModel para acessar o carrinho
                model: CartModel(user: model), //enviando o usuário atual 
                child: MaterialApp(
                    title: 'Loja virtual',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: const Color.fromARGB(255, 4, 125, 141),
                    ),
                    home: HomeScreen()),
              );
                },
              )
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
