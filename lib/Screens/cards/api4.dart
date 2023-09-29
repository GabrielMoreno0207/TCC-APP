import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class Api4CardWidget extends StatelessWidget {
  const Api4CardWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C232E),
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                ' ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildChartCard(
              'Coleta de Resíduos - Porcentagem média das cidades',
              400,
              <_ChartData>[
                _ChartData('Papel/papelão', 12, Colors.red),
                _ChartData('Plástico', 15, Colors.blue),
                _ChartData('Vidro', 30, Colors.green),
                _ChartData('Metal', 6.4, Colors.orange),
                _ChartData('Outros', 14, Colors.purple),
              ],
            ),
            _buildDonutChartCard(
              'Gráfico de Rosca',
              260,
              <_ChartData>[
                _ChartData('papel', 20, Colors.red),
                _ChartData('plastico', 30, Colors.green),
                _ChartData('metal', 25, Colors.blue),
                _ChartData('vidro', 10, Colors.orange),
                _ChartData('outros', 10, Colors.pink),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, double height, List<_ChartData> data) {
    return Card(
      elevation: 2.0,
      color:
          const Color(0xFF2C3947), // Defina a cor de fundo personalizada aqui
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Gold',
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

  Widget _buildDonutChartCard(
      String title, double height, List<_ChartData> data) {
    return Card(
      elevation: 2.0,
      color:
          const Color(0xFF2C3947), // Defina a cor de fundo personalizada aqui
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries<_ChartData, String>>[
                  DoughnutSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    innerRadius: '40%',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
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
