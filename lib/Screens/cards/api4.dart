import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Api4CardWidget extends StatefulWidget {
  const Api4CardWidget({Key? key}) : super(key: key);

  @override
  _Api4CardWidgetState createState() => _Api4CardWidgetState();
}

class _Api4CardWidgetState extends State<Api4CardWidget> {
  double somaPapelPapelao = 0.0;
  double somaPlastico = 0.0;
  double somaMetais = 0.0;
  double somaVidros = 0.0;
  double somaOutros = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarEAnalisarJson();
  }

  Future<void> _carregarEAnalisarJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data.json');
      final jsonData = json.decode(jsonString);

      for (var item in jsonData) {
        somaPapelPapelao += (item['Papel/Papelão'] ?? 0.0) / 1000;
        somaPlastico += (item['Plastico'] ?? 0.0) / 1000;
        somaMetais += (item['Metais'] ?? 0.0) / 1000;
        somaVidros += (item['Vidros'] ?? 0.0) / 1000;
        somaOutros += (item['Outros'] ?? 0.0) / 1000;
      }

      setState(() {});
    } catch (error) {
      print('Erro ao carregar e analisar o JSON: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C232E),
      elevation: 2.0,
      child: Container(
        height: 500,
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 1.0),
        child: Column(
          children: [
            SizedBox(height: 20), // Adicione um espaço vazio
            const Center(
              child: Text(
                'Coleta de Residuos - Porcentagem Média por Cidade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 50, interval: 10),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData('Papel', somaPapelPapelao, Colors.red),
                      _ChartData('Plástico', somaPlastico, Colors.blue),
                      _ChartData('Vidro', somaVidros, Colors.green),
                      _ChartData('Metal', somaMetais, Colors.orange),
                      _ChartData('Outros', somaOutros, Colors.purple),
                    ],
                    xValueMapper: (_ChartData data, _) => data.category,
                    yValueMapper: (_ChartData data, _) => data.value,
                    name: 'Porcentagem',
                    pointColorMapper: (_ChartData data, _) => data.color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}
