import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlutterPage extends StatefulWidget {
  const FlutterPage({Key? key});

  @override
  _FlutterPageState createState() => _FlutterPageState();
}

class _FlutterPageState extends State<FlutterPage> {
  final TextEditingController _cepController = TextEditingController();
  String _cidade = '';
  String _uf = '';

  void _fetchCEPData(String cep) async {
    final resposta =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (resposta.statusCode == 200) {
      Map<String, dynamic> data = json.decode(resposta.body);
      setState(() {
        _cidade = data['localidade'];
        _uf = data['uf'];
      });
    } else {
      setState(() {
        _cidade = 'Cidade não encontrada';
        _uf = 'UF não encontrado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C232E),
      appBar: AppBar(
        title: const Text(
          'Como funciona uma API?',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1C232E),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(
              title: 'O que é uma API?',
              content:
                  'Uma API, ou Interface de Programação de Aplicativos, é como um guia que permite que diferentes programas conversem entre si. Ela define regras claras para como um software pode solicitar e receber informações de outro software, como pedir um sanduíche em um restaurante. O software que oferece a API age como o atendente do restaurante, aceitando os pedidos e fornecendo o que é necessário. Isso torna mais fácil para diferentes programas trabalharem juntos, mesmo que tenham sido feitos por pessoas diferentes. As APIs são como pontes que conectam diferentes partes de um mundo digital, permitindo que eles compartilhem dados e funcionem juntos de maneira harmoniosa.',
            ),
            _buildCard(
              title: 'Exemplo de Formato de Retorno',
              content:
                  'O exemplo abaixo mostra o que uma API de CEP retorna e também como você pode manipular essas informações:',
              code: true,
              codeContent: '''{
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP",
  "ibge": "3550308",
  "gia": "1004",
  "ddd": "11",
  "siafi": "7107"
}''',
            ),
            _buildCard(
              title: 'Digite um CEP',
              content: 'Digite um CEP para obter a cidade e o UF:',
              child: Column(
                children: [
                  TextFormField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'CEP',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _fetchCEPData(_cepController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00CC76),
                    ),
                    child: const Text('Buscar'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cidade: $_cidade',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'UF: $_uf',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String content,
    Widget? child,
    bool code = false,
    String? codeContent,
  }) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2.0,
      color: const Color(0xFF3F3D56),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            if (code) const SizedBox(height: 10),
            if (code)
              Container(
                color: const Color(0xFF1C232E),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  codeContent!,
                  style: const TextStyle(
                    color: const Color(0xFF00CC76),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            if (child != null) const SizedBox(height: 20),
            if (child != null) child,
          ],
        ),
      ),
    );
  }
}
