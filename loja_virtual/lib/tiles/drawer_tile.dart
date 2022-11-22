import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({super.key, required this.icon, required this.text, required this.controller, required this.page});

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  @override
  Widget build(BuildContext context) {
    //material - para dar um efeito visual ao clicar nos botões
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //para fechar o drawer
          Navigator.of(context).pop();
          //indo para a página que especificamos no tile
          controller.jumpToPage(page);
        },
        //container para expecificar a altura dos itens
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                //.round() para arredondar o valor que vem do controller.page, pois é um double e o page é um int
                //se o page controller estiver na página especificada no tile
                color: controller.page!.round() == page
                //pinta da cor do tema padrão
                ? Theme.of(context).primaryColor
                //se não estiver na página
                : Colors.grey[700],
              ),
              const SizedBox(width: 32),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.page!.round() == page
                ? Theme.of(context).primaryColor
                : Colors.grey[700],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
