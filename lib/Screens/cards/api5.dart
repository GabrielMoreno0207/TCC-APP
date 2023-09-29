import 'dart:async';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<String> cards = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
  ];
  List<bool> cardFlips = List.filled(8, false);
  List<int> selectedCards = [];
  bool canFlip = true;
  int pairsFound = 0;

  @override
  void initState() {
    super.initState();
    cards.shuffle();
  }

  void _flipCard(int index) {
    if (!canFlip || cardFlips[index]) return;

    setState(() {
      cardFlips[index] = true;
      selectedCards.add(index);

      if (selectedCards.length == 2) {
        canFlip = false;
        if (cards[selectedCards[0]] == cards[selectedCards[1]]) {
          pairsFound++;
          if (pairsFound == 4) {
            _showCongratulationsDialog();
          }
          // Reseta o estado para permitir a próxima escolha
          selectedCards.clear();
          canFlip = true;
        } else {
          Timer(const Duration(seconds: 1), () {
            setState(() {
              cardFlips[selectedCards[0]] = false;
              cardFlips[selectedCards[1]] = false;
              selectedCards.clear();
              canFlip = true;
            });
          });
        }
      } else if (selectedCards.length > 2) {
        cardFlips[selectedCards[0]] = false;
        cardFlips[selectedCards[1]] = false;
        selectedCards.clear();
        selectedCards.add(index);
      }
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Parabéns!'),
          content: const Text('Você encontrou todos os pares de cartas.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Reiniciar'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      cards.shuffle();
      cardFlips = List.filled(8, false);
      selectedCards.clear();
      canFlip = true;
      pairsFound = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Memória'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _flipCard(index);
            },
            child: Card(
              color: cardFlips[index]
                  ? const Color(0xFF00CC76)
                  : Colors.black, // Cor do card quando virado e verso escuro
              child: Center(
                child: Image.asset(
                  cards[index], // Caminho das imagens
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
