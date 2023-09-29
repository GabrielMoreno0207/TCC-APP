import 'dart:ui';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tcc_app/Screens/cards/api1.dart';
import 'package:tcc_app/Screens/cards/api2.dart';
import 'package:tcc_app/Screens/cards/api3.dart';
import 'package:tcc_app/Screens/cards/api4.dart';
import 'package:tcc_app/Screens/cards/api5.dart';
import 'package:tcc_app/Screens/flutter.dart';
import 'package:tcc_app/Screens/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const FlutterPage(),
    const ConfigPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C232E),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          _pages[_pageIndex],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF00CC76),
        index: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.info, size: 30),
          Icon(Icons.code, size: 30),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Image.asset(
            'assets/images/logo.png',
            height: 80,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: buildGradientCard(
                    context,
                    'Qualidade do ar',
                    LinearGradient(
                      colors: [Colors.green[300]!, Colors.green[900]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Api1CardWidget(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: buildGradientCard(
                    context,
                    'Calcule a pegada de Carbono',
                    LinearGradient(
                      colors: [Colors.blue[300]!, Colors.blue[900]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Api2CardWidget(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildGradientCard(
                    context,
                    'Pergunte ao GPT',
                    LinearGradient(
                      colors: [Colors.purple[300]!, Colors.purple[900]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatGPTScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: buildGradientCard(
                    context,
                    'Dados sobre Reciclagem',
                    LinearGradient(
                      colors: [Colors.orange[300]!, Colors.orange[900]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Api4CardWidget(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        buildGradientCard(
          context,
          'Jogo da Memória',
          LinearGradient(
            colors: [Colors.red[300]!, Colors.red[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MemoryGameScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildGradientCard(
    BuildContext context,
    String cardTitle,
    LinearGradient gradient,
    void Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.0,
        child: Container(
          height: 110,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              cardTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
