import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarbonFootprintCalculator extends StatefulWidget {
  @override
  _CarbonFootprintCalculatorState createState() =>
      _CarbonFootprintCalculatorState();
}

class _CarbonFootprintCalculatorState extends State<CarbonFootprintCalculator> {
  final TextEditingController electricityUsageController =
      TextEditingController();
  final TextEditingController vehicleDistanceController =
      TextEditingController();
  Map<String, dynamic> result = {};

  Future<void> calculateCarbonFootprint() async {
    final apiUrl = 'https://www.carboninterface.com/api/v1/estimates';

    try {
      // Cálculo para eletricidade
      final electricityResponse = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer gn8jZtrXKAiCru3KP6B4w', // Substitua pela sua chave de API
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "type": "electricity",
          "electricity_unit": "kwh",
          "electricity_value": double.parse(electricityUsageController.text),
          "country": "us", // Altere para o código ISO do Brasil
          "state": "fl", // Altere para o código ISO de São Paulo
        }),
      );

      if (electricityResponse.statusCode == 201) {
        final electricityData = json.decode(electricityResponse.body);
        final electricityAttributes = electricityData['data']['attributes'];

        // Cálculo para veículo
        final vehicleResponse = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Authorization':
                'Bearer gn8jZtrXKAiCru3KP6B4w', // Substitua pela sua chave de API
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "type": "vehicle",
            "distance_unit": "mi", // Defina a unidade de distância (mi ou km)
            "distance_value": double.parse(vehicleDistanceController.text),
            "vehicle_model_id":
                "7268a9b7-17e8-4c8d-acca-57059252afe9", // Substitua pelo modelo de veículo desejado
          }),
        );

        if (vehicleResponse.statusCode == 201) {
          final vehicleData = json.decode(vehicleResponse.body);
          final vehicleAttributes = vehicleData['data']['attributes'];

          setState(() {
            result = {
              'Eletricidade - Emissão: (kg CO2)':
                  electricityAttributes['carbon_kg'].toString(),
              'Eletricidade - Emissão: (g CO2)':
                  electricityAttributes['carbon_g'].toString(),
              'Eletricidade - Emissão: (lb CO2)':
                  electricityAttributes['carbon_lb'].toString(),
              'Eletricidade - Emissão: (ton CO2)':
                  electricityAttributes['carbon_mt'].toString(),
              'Veículo - Emissão: (kg CO2)':
                  vehicleAttributes['carbon_kg'].toString(),
              'Veículo - Emissão: (g CO2)':
                  vehicleAttributes['carbon_g'].toString(),
              'Veículo - Emissão: (lb CO2)':
                  vehicleAttributes['carbon_lb'].toString(),
              'Veículo - Emissão: (ton CO2)':
                  vehicleAttributes['carbon_mt'].toString(),
            };
          });
        }
      } else {
        setState(() {
          result = {
            'Erro na chamada da API': electricityResponse.statusCode.toString(),
          };
        });
      }
    } catch (e) {
      setState(() {
        result = {
          'Erro na chamada da API': e.toString(),
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1C232E),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Informe o consumo de eletricidade (kWh):',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                        controller: electricityUsageController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Informe a distância da viagem do veículo (mi):',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                        controller: vehicleDistanceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: calculateCarbonFootprint,
                        child: Text('Calcular Pegada de Carbono'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: result.keys.map((key) {
                      return Column(
                        children: <Widget>[
                          Text(
                            '$key:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${result[key]}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
