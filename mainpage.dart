import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const CryptoExchange());
  }
}

class CryptoExchange extends StatefulWidget {
  const CryptoExchange({Key? key}) : super(key: key);
  @override
  State<CryptoExchange> createState() => _CryptoExchangeState();
}

class _CryptoExchangeState extends State<CryptoExchange> {
  String name = "";
  String unit = "";
  String type = "";
  double value = 0.0;
  String description = "";

  String selectCurrency = "eth";
  List<String> currencyList = [
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "bits",
    "sats",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "czk",
    "ddk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "jpy",
    "krw",
    "kwd",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "rub",
    "sar",
    "sek",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
  ];

  String selectCoin = "btc";
  List<String> coinList = ["btc"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 216, 240),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 181, 177, 240),
            title: const Text("Crypto App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              " Crypto And Fiat Money Exchange ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectCoin,
              onChanged: (newValue) {
                setState(() {
                  selectCoin = newValue.toString();
                });
              },
              items: coinList.map((selectCoin) {
                return DropdownMenuItem(
                  child: Text(
                    selectCoin,
                  ),
                  value: selectCoin,
                );
              }).toList(),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectCurrency,
              onChanged: (newValue) {
                setState(() {
                  selectCurrency = newValue.toString();
                });
              },
              items: currencyList.map((selectCurrency) {
                return DropdownMenuItem(
                  child: Text(
                    selectCurrency,
                  ),
                  value: selectCurrency,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadValue, child: const Text("Exchange")),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        )));
  }

  Future<void> _loadValue() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      var name = parsedJson['rates'][selectCurrency]['name'];
      var unit = parsedJson['rates'][selectCurrency]['unit'];
      var value = parsedJson['rates'][selectCurrency]['value'];
      var type = parsedJson['rates'][selectCurrency]['type'];

      setState(() {
        description =
            " The selected choice is $selectCurrency.The name is $name. The unit is $unit and the type is $type.The value is $value.";
      });
      progressDialog.dismiss();
    }
  }
}
