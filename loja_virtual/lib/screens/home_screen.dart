import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/orders_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import '../tabs/home_tab.dart';
import '../tabs/places_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //várias páginas
    return PageView(
      //com esse physics não dá para rolar entre as telas arrastando pro lado
      //pode controlar somente pelo código
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: const CartButton(), //botão do carrinho
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const ProductsTab(),  
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Lojas'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: const OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
      ],
    );
  }
}
