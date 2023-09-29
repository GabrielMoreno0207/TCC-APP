import 'package:flutter/material.dart';

class Api2CardWidget extends StatelessWidget {
  const Api2CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C232E),
      elevation: 2.0,
      child: Container(
        height: 100, // Ajuste aqui a altura desejada
        padding: const EdgeInsets.all(16.0),
        child: const Center(
          child: Text(
            'Api 2 Card',
            style: TextStyle(
              color: Colors.white, // Altera a cor do texto para branca
              fontSize: 18.0, // Ajuste aqui o tamanho da fonte desejado
              fontWeight:
                  FontWeight.bold, // Ajuste aqui a espessura da fonte desejada
            ),
          ),
        ),
      ),
    );
  }
}
