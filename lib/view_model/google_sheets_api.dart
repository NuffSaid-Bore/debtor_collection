import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
// create google sheet credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "flutter-debtor-collection",
  "private_key_id": "ecdc1a086e85bc4632c9cbfa399bdb26aa188f71",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCrHSPzcJy0NhVP\ndrReFhdpH5UPr4kOsDfL/LtMiWCjGcn2mlIPrRNtUz+Kooer2NXUaPbS0wSimoww\n6QEmYlTCShguw3c52NZTrdhujn7ExQyzMp3q+IdH6sTfAQig5cBrRx2h7ZJ6vdku\nOM6AIonYL1CQUpY8FyM2+JSBF+/wbxpbAP/QWD3j3ZIipxSDv+HiE9oUVLefOnXC\n5Ro5m6sAlQSuDupEiKfrONI+88y27CyFhRaN+C1+0VIXHZ1oA2Wvv543uneYpEDX\nJDzqPRRvf31AN5RjzpuX6ZXD42F0VfXmLaOfGGyNrXtIsJHXVAr3obRMMRuZg96G\nwdmGBTBTAgMBAAECggEABSxw4VPm0QYPl+L5ahzV4V5MlfhTNwf57+d4zEQdEWFe\nu1+IGqQ7gaMyOSFX48i/EliIGfC6Y6Yzlej9mWkAsg0mdQeA69VUCZyofhM93vos\nO6DMqIWSJYkCIdH4rlC0BCpWyYYS1zY1QlICYFpq+4fWsj5k/3UdofRbHRoZrZXJ\nuIvbnoXc+Wnx8sTvfBRVkGZdRZMQ+MKSFKXgUUvaxJmVQV2bwRsq+yY2QlDXg7hB\nzu4BEeuhJMyYLRw9FB6xmj///tKqFVY3zS7AjIrLEKEnNkJxUcnkmxHaGyE9wKMm\nfZkmg9hSGWSGtrFLvm+s5bNIL8m49a0q2wGdRbjreQKBgQDTU/4tdppGRpWMMvws\nhlyGLOTiKytooKuJKU0GzUcn7YWYi7rBtYUUM6Qf+3DRvtS5XDMuAH82dKZ1G8Oc\nZr4KljUMy8Ee2K7rAUtQnhIBFW4qJHIlphDWalOhy6ZCtSsklkNKvyePXb2HY/+v\n8wsqDS/r+QjpNYbGEbzO7/crewKBgQDPSPR1qyMgmRfJYXBZGR+0weseazeUIttM\nkEwtoKHDKTyHuU+Od0CLuwtPKuMPDQz7Pog8Js0glcvodCjzMwpZffopLyrGoUzY\n2hqWu318+pB5GmUK+QOtq1zTer7Y3i/GbXucxHGMq9G1E4XeX5yeVPFQCQLDS7+H\nq+519+UrCQKBgQC3IRoqm5SlQZVmoOgWTXjwbQcLVw2O5WzAt6GgO1NmLlaPEscM\nBhkEoJuhe2sQ16XP2y4etx+GOR/ma+DfL8mPswrVw9vetzcdP0nc2p4Pglqs+lhQ\nd9AvfoRquOei9wwj8HLv2yaU/k63fNidyKfsEPFuM6idL11TVxue2CQA8QKBgQCH\nW7CnFjY+Fzq9Om/O/uUBeJA8sO7+QTTLbn8QXJDFjKwGRTB6a80ucdoUvIDBV1he\nyJrWDNBusuMQzKnhBjd/8Q/mzPI1+ybfhK1QOObdMhIdwuqwm6OXSQu43bK6k3zH\nKr9Jw84SejDa+gC1EeKIUheyl+/B8DkGM3PofRSdYQKBgQC3j3RfqdzZ8gWOmTsk\nst8KGKjxAATUZSL0vnadu4aNZ9RxhILA8eZboe6BIu4MpfKHrAaPgpXVxkkqJtZ6\nTZFH65MeQwSPJTV8q/vzoGdBafm+QbRBfpmALjITab7E7Qla0F/mfqABRXcXTTm3\nXnFA8jNkClfrG6SOZqWnxuyfAA==\n-----END PRIVATE KEY-----\n",
  "client_email": "debtorcollection@flutter-debtor-collection.iam.gserviceaccount.com",
  "client_id": "106490043937669868177",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/debtorcollection%40flutter-debtor-collection.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';

  //Set up and connect to google spreadsheet
  //Spreadsheet ID
  static const _spreadsheetId = '1n5OTDbEAgFu3lk58CJvbEef8Tem-yMcYlqTvDtUmHjk';
  static final _gsheet = GSheets(_credentials);
  static Worksheet? _worksheet;

//variable to help keep track
  static int numberOftransaction = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool isLoading = true;

  //initialize spreadsheet
  Future init() async {
    final spreadSheet = await _gsheet.spreadsheet(_spreadsheetId);

    _worksheet = await _getWorkSheet(spreadSheet, title: 'Sheet1');
    // _worksheet = spreadSheet.worksheetByTitle('Sheet1');
    // countrows();
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
        try{
          return await spreadsheet.addWorksheet(title);
        }catch(e){
          return spreadsheet.worksheetByTitle(title)!;
        }
    
  }

  //count he number of rows
  static Future countrows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOftransaction + 1)) !=
        '') {
      numberOftransaction++;
    }
    loadTransaction();
  }

  static Future loadTransaction() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOftransaction; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionDate =
          await _worksheet!.values.value(column: 3, row: i + 1);
      final String transactionReturndate =
          await _worksheet!.values.value(column: 4, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 5, row: i + 1);

      if (currentTransactions.length < numberOftransaction) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionDate,
          transactionReturndate,
          transactionType,
        ]);
      }
    }
    isLoading = false;
  }

  // insert a new transaction
  static Future insert(
      String name, String amount, String returnDate, bool isDebt) async {
    if (_worksheet == null) return;
    numberOftransaction++;
    currentTransactions.add([
      name,
      amount,
      returnDate,
      isDebt ? 'Debt' : 'Income',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      returnDate,
      isDebt ? 'Debt' : 'Income',
    ]);
  }

  //calculate income
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][4] == 'Income' ||
          currentTransactions[i][4] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  //calculate Debt
  static double calculateDebt() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][4] == 'Debt' ||
          currentTransactions[i][4] == 'debt') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }
}
