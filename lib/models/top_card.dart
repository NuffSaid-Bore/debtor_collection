import 'package:debtor_collection/utils/info_row.dart';
import 'package:flutter/material.dart';

class TopNuemorphCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;
  const TopNuemorphCard({
    super.key,
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepPurple[300],
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade500,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.deepPurple.shade300,
              offset: const Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'B A L A N C E',
                  style: TextStyle(color: Colors.deepPurple[500], fontSize: 16),
                ),
              ),
              Text(
                'R$balance',
                style: TextStyle(color: Colors.deepPurple[800], fontSize: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoRow(
                    icon: Icons.arrow_upward,
                    iconColor: Colors.green,
                    label: 'Income',
                    value: 'R $income',
                    iconPosition: IconPosition.beforeText,
                  ),
                  InfoRow(
                      icon: Icons.arrow_downward,
                      iconColor: Colors.red,
                      label: 'Expense',
                      value: 'R $expense',
                      iconPosition: IconPosition.afterText),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
