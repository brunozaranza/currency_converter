import 'package:currency_converter/core/models/api_response_live_currencies.dart';
import 'package:currency_converter/core/models/api_response_supported_currencies.dart';
import 'package:currency_converter/core/models/base_api_response.dart';
import 'package:currency_converter/core/repositories/database/database.dart';
import 'package:currency_converter/core/repositories/services/currency_service.dart';
import 'package:flutter/material.dart';

class CurrencyViewModel extends ChangeNotifier {
  List<String> currenciesToCompare;
  ApiResponseSupportedCurrencies supportedCurrencies;
  ApiResponseLiveCurrencies liveCurrencies;

  double _value0;
  double _value1;

  CurrencyViewModel({
    this.currenciesToCompare,
    this.supportedCurrencies,
    this.liveCurrencies,
  }) {
    Database.getCurrenciesToCompare().then((list) {
        this.currenciesToCompare = list;
    });
  }

  Future<void> fetchAllSupported({bool forceUpdate = false}) async {
    BaseApiResponse<ApiResponseSupportedCurrencies> response =
        await CurrencyService.getAllSupported(forceUpdate: forceUpdate);
    this.supportedCurrencies = response.result;
    notifyListeners();
  }

  Future<void> fetchAllLive({bool forceUpdate = false}) async {
    BaseApiResponse<ApiResponseLiveCurrencies> response =
        await CurrencyService.getAllLive(forceUpdate: forceUpdate);
    this.liveCurrencies = response.result;
    notifyListeners();
  }

  void changeCurrencyPositions() {
    this.currenciesToCompare = currenciesToCompare.reversed.toList();

    double aux0 = this.value0;
    double aux1 = this.value1;

    this._value0 = aux1;
    this._value1 = aux0;

    notifyListeners();
  }

  void updateCurrenciesSelected({int index, String title}) {
    this.currenciesToCompare[index] = title;
    Database.saveCurrenciesToCompare(currenciesToCompare);
    notifyListeners();
  }

  void clearValues() {
    this._value0 = 0;
    this._value1 = 0;
    notifyListeners();
  }

  Future<bool> updateValues({@required int index, @required double value}) async {

    String source = this.liveCurrencies.source;

    if (index == 0) {
      this._value0 = value;
      if (currenciesToCompare.first != source) {
        double valueSource = value /
            liveCurrencies.currencies["$source${currenciesToCompare.first}"];
        this._value1 = valueSource *
            liveCurrencies.currencies["$source${currenciesToCompare.last}"];
      } else {
        this._value1 = value *
            liveCurrencies.currencies[
                "${currenciesToCompare.first}${currenciesToCompare.last}"];
      }
    } else {
      this._value1 = value;
      if (currenciesToCompare.last != source) {
        double valueSource = value /
            liveCurrencies.currencies["$source${currenciesToCompare.last}"];
        this._value0 = valueSource *
            liveCurrencies.currencies["$source${currenciesToCompare.first}"];
      } else {
        this._value0 = value *
            liveCurrencies.currencies[
                "${currenciesToCompare.first}${currenciesToCompare.first}"];
      }
    }

    notifyListeners();

    return true;
  }

  List<String> get listToCompare {

    if (this.currenciesToCompare == null)
      this.currenciesToCompare = [null, null];

    return this.currenciesToCompare;
  }

  Map<String, dynamic> get supported {
    if (supportedCurrencies == null) return null;
    return this.supportedCurrencies.currencies;
  }

  Map<String, dynamic> get live {
    if (liveCurrencies == null) return null;
    return this.liveCurrencies.currencies;
  }

  double get value0 {
    return this._value0;
  }

  double get value1 {
    return this._value1;
  }
}
