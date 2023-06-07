import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '3605B84F-BD13-4219-9173-963202B630D9';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        var codedData = response.body;
        var decodedData = jsonDecode(codedData);
        var rate = decodedData['rate'];
        cryptoPrices[crypto] = rate.toString();
        print('this is my map!');
        print(cryptoPrices);
      } else {
        print('ERROR ERROR');
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
