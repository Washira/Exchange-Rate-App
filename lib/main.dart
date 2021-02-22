import 'package:flutter/material.dart';
import 'moneyBox.dart';
import 'package:http/http.dart' as http;
import 'exchangeRate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExchangeRateCurrency _dataFromAPI;
  @override
  void initState() {
    super.initState();
    print("เรียกใช้งาน init state");
    getExchangeRate();
  }

  Future<ExchangeRateCurrency> getExchangeRate() async {
    var url = "https://api.exchangeratesapi.io/latest?base=THB";
    var response = await http.get(url);
    _dataFromAPI = exchangeRateCurrencyFromJson(response.body);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    print("เรียกใช้งาน build");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Exchange Rate",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
            future: getExchangeRate(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var result = snapshot.data;
                double amout = 100;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MoneyBox("สกุลเงิน THB", amout, Colors.lightBlue, 150),
                      SizedBox(
                        height: 5,
                      ),
                      MoneyBox("สกุลเงิน USD", amout*result.rates["USD"],
                          Colors.lightGreen, 100),
                      SizedBox(
                        height: 5,
                      ),
                      MoneyBox("สกุลเงิน EUR", amout*result.rates["EUR"],
                          Colors.orangeAccent, 100),
                      SizedBox(
                        height: 5,
                      ),
                      MoneyBox("สกุลเงิน GBP", amout*result.rates["GBP"],
                          Colors.greenAccent, 100),
                      SizedBox(
                        height: 5,
                      ),
                      MoneyBox("สกุลเงิน JPY", amout*result.rates["JPY"],
                          Colors.redAccent, 100),
                    ],
                  ),
                );
              }
              return LinearProgressIndicator();
            }));
  }
}
