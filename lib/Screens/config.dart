import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C232E),
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: const Color(0xFF1C232E),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: const Color(0xFF1C232E),
          elevation: 2.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/profile_image.jpg'), // Replace with your image
                ),
                const SizedBox(height: 20),
                const Text(
                  'Desenvolvido por:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const Text(
                  'Gabriel Moreno',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Open your social media link
                      },
                      icon: const Icon(
                        Icons.email,
                        color: Color(0xFF00CC76),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your logout functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 4, 172, 102), // Use a red color for the button
                  ),
                  child: const Text('Sair'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
