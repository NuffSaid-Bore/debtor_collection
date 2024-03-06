import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDebtors extends StatelessWidget {
  final String debtorName;
  final String debtAmount;
  final String incomeorDebt;
  final DateTime debtDate;
  final DateTime returnDate;

  MyDebtors(
      {Key? key,
      required this.debtorName,
      required this.debtAmount,
      required this.returnDate,
      required this.incomeorDebt})
      : debtDate = DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 70,
        color: Colors.deepPurple[300],
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.deepPurple[600],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.money,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          debtorName,
                          style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${incomeorDebt == 'income' ? '+' : '-'}R$debtAmount',
                          style: TextStyle(
                            color: (incomeorDebt == 'income'
                                ? Colors.green
                                : Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formattedDate(debtDate),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'Return By: ${_formattedDate(returnDate)}',
                    style: TextStyle(
                      color: Colors.deepPurple[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formattedDate(DateTime date) {
    // Format the date as needed, e.g., "yyyy-MM-dd" or dd/MM/yyyy
    // return "${debtDate.day}/${debtDate.month}/${debtDate.year}";
    return DateFormat('yyyy/MM/dd').format(date);
  }
}
