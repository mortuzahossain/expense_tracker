import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Reports'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // TODO: Show date range picker
          },
          child: const Icon(CupertinoIcons.calendar),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionTitle('Income vs Expense'),
            const SizedBox(height: 16),
            _buildBarChart(context),
            const SizedBox(height: 32),
            _buildSectionTitle('Expense by Category'),
            const SizedBox(height: 16),
            _buildPieChart(context),
            const SizedBox(height: 32),
            _buildSectionTitle('Account Balances'),
            const SizedBox(height: 16),
            _buildAccountSummary(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: CupertinoColors.label),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 6500,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: CupertinoColors.secondaryLabel,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Income';
                      break;
                    case 1:
                      text = 'Expense';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4.0,
                    child: Text(text, style: style),
                  );
                },
                reservedSize: 38,
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(toY: 6200, color: CupertinoColors.systemGreen, width: 40, borderRadius: BorderRadius.circular(4))
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 117.50, color: CupertinoColors.systemRed, width: 40, borderRadius: BorderRadius.circular(4))
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(color: CupertinoColors.systemBlue, value: 40, title: '40%', radius: 50),
            PieChartSectionData(color: CupertinoColors.systemGreen, value: 30, title: '30%', radius: 50),
            PieChartSectionData(color: CupertinoColors.systemYellow, value: 15, title: '15%', radius: 50),
            PieChartSectionData(color: CupertinoColors.systemRed, value: 15, title: '15%', radius: 50),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildAccountSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildAccountItem('Bank Account 1', '\$1,500.00'),
          _buildAccountItem('Cash', '\$250.00'),
          _buildAccountItem('Savings', '\$5,000.00'),
        ],
      ),
    );
  }

  Widget _buildAccountItem(String name, String balance) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16)),
          Text(balance, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
