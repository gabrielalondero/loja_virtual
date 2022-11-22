import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //tile que pode clicar e ela irá expandir
      child: ExpansionTile(
        iconColor: Theme.of(context).primaryColor,
        leading: const Icon(Icons.location_on),
        title: Text(
          'Carcular Frete',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'Digite seu CEP',
              ),
              //inicia com um cupom já colocado, senão coloca vazio
              initialValue: '',
              //ao submeter o cupom, busca no firestore o doc correspondente
              onFieldSubmitted: (text) {}
            ),
          ),
        ],
      ),
    );
  }
}