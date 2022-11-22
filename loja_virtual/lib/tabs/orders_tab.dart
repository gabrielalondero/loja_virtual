import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';

import '../screens/login_screen.dart';
import '../tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});  

  @override
  Widget build(BuildContext context) {
    //se está logado, carega todos os pedidos do usuário
    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser!.uid; //uid do user
      //quando obtem um documetno é um DocumentSnapshot, Quando é mais de um documento é um query snapshot
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid)
          .collection('orders').get(), //pegando os pedidos do user
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }else{
            return ListView(
              children: snapshot.data!.docs.map((doc) => OrderTile(orderId: doc.id)).toList()
                .reversed.toList(), // reversed para que os pedidos mais recentes fiquem em cima
            );
          }
        },
      );

    }else{
      return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.view_list,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Faça login para acompanhar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
    }
  }
}