import 'dart:async';
import 'package:debtor_collection/utils/plus_floating_button.dart';
import 'package:debtor_collection/view_model/google_sheets_api.dart';
import 'package:debtor_collection/views/loading_circle.dart';
import 'package:debtor_collection/models/top_card.dart';
import 'package:debtor_collection/models/transaction_window.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _formKey = GlobalKey<FormState>();
  final _textcontrollerAmount = TextEditingController();
  final _textcontrollerName = TextEditingController();
  final _textcontrollerDate = TextEditingController();
  bool _isIncome = false;
  // final _textcontrollerAmount = TextEditingController();
  // final _textcontrollerAmount = TextEditingController();
  // final _textcontrollerAmount = TextEditingController();

  //waiting Fetching data from googlesheet api
  bool timerStarted = false;

  void startLoading() {
    timerStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.isLoading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  // Boolean variable to track validation status
  bool _hasError = false;

// Add new transaction to the database
  void _enterTransaction() {
    GoogleSheetsApi.insert(_textcontrollerName.text, _textcontrollerAmount.text,
        _textcontrollerDate.text, _isIncome);
    setState(() {});
  }

// Add a new transaction method that uses a pop-up dialog to save data
  void _newTransaction() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple[200],
            title: Text(
              'N E W  T R A N S A C T I O N',
              style: TextStyle(
                color: Colors.deepPurple[500],
                fontWeight: FontWeight.bold,
                fontSize: 16.00,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Debt',
                          style: TextStyle(
                            color: Colors.deepPurple[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _isIncome = newValue;
                            });
                          },
                        ),
                        Text(
                          'Income',
                          style: TextStyle(
                            color: Colors.deepPurple[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: _hasError
                                    ? Colors.red
                                    : Colors.deepPurple[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a Name';
                              }
                              return null;
                            },
                            controller: _textcontrollerName,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Amount',
                              hintStyle: TextStyle(
                                color: _hasError
                                    ? Colors.red
                                    : Colors.deepPurple[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter an Amount';
                              }
                              return null;
                            },
                            controller: _textcontrollerAmount,
                          ),
                        ),
                      ],
                    ),
                    // Add your Text Input here
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today_rounded,
                          color: _hasError
                              ? Colors.red
                              : Colors.deepPurple[
                                  500], // Update icon color based on _hasError
                        ),
                        border: const OutlineInputBorder(),
                        hintText: 'Return Date',
                        hintStyle: TextStyle(
                          color: _hasError
                              ? Colors.red
                              : Colors.deepPurple[
                                  500], // Update hint text color based on _hasError or empty text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a return Date';
                        }
                        return null;
                      },
                      controller: _textcontrollerDate,
                      onTap: () async {
                        DateTime? datepicker = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200),
                        );
                        if (datepicker != null) {
                          setState(() {
                            _textcontrollerDate.text =
                                DateFormat('yyyy-MM-dd').format(datepicker);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.deepPurple[300],
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.deepPurple[600]),
                ),
                onPressed: () {
                  setState(
                    () {
                      _hasError = false;
                    },
                  );
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                color: Colors.deepPurple[300],
                child: Text(
                  'Save Entry',
                  style: TextStyle(color: Colors.deepPurple[600]),
                ),
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // If form is valid, reset _hasError to false and enter transaction
                    setState(() {
                      _hasError = false;
                    });
                    _enterTransaction();
                    Navigator.of(context).pop();
                  } else {
                    // If form has validation errors, set _hasError to true
                    setState(() {
                      _hasError = true;
                    });
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.isLoading == true && timerStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TopNuemorphCard(
              // Look for how  i can use the balance in the GoogsheetAPI
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateDebt())
                  .toString(),
              expense: GoogleSheetsApi.calculateDebt().toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // MyDebtors(
                    //   debtorName: 'Kamohelo',
                    //   debtAmount: '100',
                    //   incomeorDebt: 'debt',
                    //   returnDate: DateTime.utc(2024, 2, 15),
                    // )
                    Expanded(
                      child: GoogleSheetsApi.isLoading == true
                          ? SpinKitDoubleBounce(color: Colors.deepPurple[600])
                          : ListView.builder(
                              itemCount:
                                  GoogleSheetsApi.currentTransactions.length,
                              itemBuilder: (context, index) => MyDebtors(
                                debtorName: GoogleSheetsApi
                                    .currentTransactions[index][0],
                                debtAmount: GoogleSheetsApi
                                    .currentTransactions[index][1],
                                returnDate: GoogleSheetsApi
                                    .currentTransactions[index][3],
                                incomeorDebt: GoogleSheetsApi
                                    .currentTransactions[index][4],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            PlusFloatingButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
