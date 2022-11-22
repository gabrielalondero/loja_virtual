import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
//para acessar os dados de todo o app, usa o ScopedModel<nomedomodel> no main

//use ScopedModelDescendant<nomedomodel> na parte do app que vc deseja que acesse o modelo
//e quando algo mudar no model, toda aquela parte será reconstruida

//Model é um objeto que vai guardar os estados; neste caso, guardar o login do app
//conforme vai modificando esse estado através das funções, ele vai modificar o layout do app
class UserModel extends Model {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;
  User? currentUser; //variável para quando sair do app, pegar o usuário que ficou logado
  Map<String, dynamic>? userData = {};

  bool isLoading = false;

  //outra forma para ter acesso ao UserModel de qualquer lugar do App: usar UserModel.of(context).
  //que vai buscar um objeto do tipo UserModel na árvore
  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

//quando o app abre, chama
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

//voidCallback é uma função que iremos passar e chamar de dentro da nossa função signUp
  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    //tentando criar o usuário
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((user) async {
      //se sucesso
      firebaseUser = user.user;
      //salvando os dados do usuário no firebase
      //pois ao criar o usuário ele só salva o user e a senha, os outros dados
      //devem ser salvos manualmente
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      //se der algum erro
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners(); //falando ao flutter que modificou algo no modelo, e que é para atualizar a tela

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      //se logou
      firebaseUser = user.user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      //se deu algum erro
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();
    userData = {}; //reseta os dados do usuário
    firebaseUser = null;
    notifyListeners();
  }
  //enviar um email com um link para redefinição e senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    //se o usuário atual for diferente de null, retorna true
    User? usuarioLogado = _auth.currentUser;
    return usuarioLogado != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    //salvando os dados na coleção users, no documento correspondente ao id do usuário
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  Future<void> _loadCurrentUser() async {
    //se firebaseUser for null, busca o usuário atual
    firebaseUser ??= _auth.currentUser;   
    if (firebaseUser != null) {
      DocumentSnapshot<Map<String, dynamic>> docUser = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .get();
      userData = docUser.data.call();
    }
    notifyListeners();
  }
}
