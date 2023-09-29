import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api1CardWidget extends StatefulWidget {
  const Api1CardWidget({Key? key}) : super(key: key);

  @override
  _Api1CardWidgetState createState() => _Api1CardWidgetState();
}

class _Api1CardWidgetState extends State<Api1CardWidget> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _data;
  String? _errorMessage;

  Future<void> fetchData(String cityName) async {
    final apiUrl = Uri.parse(
        'https://api.waqi.info/feed/${cityName}/?token=d3352d90cfe7bf98056581cc77367590656bf605');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
          _errorMessage = null; // Limpa a mensagem de erro
        });
      } else {
        throw Exception('Falha ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _data = null; // Limpa os dados
        _errorMessage = 'Erro: $e'; // Define a mensagem de erro
      });
    }
  }

  dynamic getValue(dynamic data, String key) {
    if (data != null && data.containsKey(key)) {
      final value = data[key];
      if (value is String) {
        final parsedValue = int.tryParse(value);
        if (parsedValue != null) {
          return parsedValue;
        } else {
          return value;
        }
      } else {
        return value;
      }
    }
    return null;
  }

  Color getColorFromAqi(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  Widget buildInfoCard(String title, String value, Color color) {
    return Card(
      color: color,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color(0xFF1C232E),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Qualidade do Ar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Digite o nome da cidade:',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Cidade',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final cityName = _cityController.text;
                  await fetchData(cityName);
                  setState(() {});
                },
                child: const Text('Pesquisar'),
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              if (_data != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Text(
                      'Qualidade do Ar em ${_data!["data"]["city"]["name"] ?? 'N/A'}:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        buildInfoCard(
                          'AQI',
                          '${getValue(_data!["data"], "aqi") ?? 'N/A'}',
                          getColorFromAqi(getValue(_data!["data"], "aqi") ?? 0),
                        ),
                        buildInfoCard(
                          'Poluente Dominante',
                          '${_data!["data"]["dominentpol"] ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                        buildInfoCard(
                          'Data e Hora da Medição',
                          '${_data!["data"]["time"]["s"] ?? 'N/A'} (${_data!["data"]["time"]["tz"] ?? 'N/A'})',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'IAQI (Índice de Qualidade do Ar Individual):',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        buildInfoCard(
                          'CO',
                          '${getValue(_data!["data"]["iaqi"], "co") ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                        buildInfoCard(
                          'NO2',
                          '${getValue(_data!["data"]["iaqi"], "no2") ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                        buildInfoCard(
                          'O3',
                          '${getValue(_data!["data"]["iaqi"], "o3") ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                        buildInfoCard(
                          'PM10',
                          '${getValue(_data!["data"]["iaqi"], "pm10") ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                        buildInfoCard(
                          'PM25',
                          '${getValue(_data!["data"]["iaqi"], "pm25") ?? 'N/A'}',
                          const Color.fromARGB(255, 151, 150, 150),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              Image.asset('assets/images/tabela_aqi.png'), // Adiciona a imagem
            ],
          ),
        ),
      ),
    );
  }
}
