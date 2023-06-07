import 'package:bitcoin_ticker_flutter/card.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

const apiKey = '3605B84F-BD13-4219-9173-963202B630D9';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  late String selectedValue;

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> myCurrencyList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      myCurrencyList.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: myCurrencyList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          fetchData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> myNewCurrencyList = [];

    for (String currency in currenciesList) {
      myNewCurrencyList.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 40,
        onSelectedItemChanged: (int selectedindex) {
          print(selectedindex);
          setState(() {
            selectedCurrency = currenciesList[selectedindex];
            fetchData();
          });
        },
        children: myNewCurrencyList);
  }

  CoinData coinData = CoinData();
  String coinValue = '?';
  bool isWaiting = false;
  Map<String, String> coinValues = {};
  void fetchData() async {
    isWaiting = true;
    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
        print('Coin value btc');
        print(coinValues['BTC']);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //First Card
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardWidget(
                coinValue: isWaiting ? '?' : coinValues['BTC'],
                selectedCurrency: selectedCurrency,
                coinName: 'BTC',
              ),
              //First Card Ends here

              //Second Card
              CardWidget(
                coinValue: isWaiting ? '?' : coinValues['ETH'],
                selectedCurrency: selectedCurrency,
                coinName: 'ETH',
              ),
              //Second Card Ends here

              //Third Card
              CardWidget(
                coinValue: isWaiting ? '?' : coinValues['LTC'],
                selectedCurrency: selectedCurrency,
                coinName: 'LTC',
              ),
              //Third Card Ends here],),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropDown() : iosPicker(),
          )
        ],
      ),
    );
  }
}
