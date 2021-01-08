import 'package:currency_converter/core/models/api_response_live_currencies.dart';
import 'package:currency_converter/core/models/api_response_supported_currencies.dart';

class BaseApiResponse<T> {
  bool success;
  T result;
  String msgError;

  BaseApiResponse({this.success, this.result, this.msgError});

  BaseApiResponse.fromJson(Map<String, dynamic> json, {String error}) {
    msgError = error == null ? "Sucesso!" : error;
    if (json == null) return;

    success = json['success'];

    if (T == ApiResponseSupportedCurrencies) {
      result = ApiResponseSupportedCurrencies.fromJson(json['currencies']) as T;
    } else if (T == ApiResponseLiveCurrencies) {
      result = ApiResponseLiveCurrencies.fromJson(
        json['quotes'],
        json["source"],
      ) as T;
    }
  }
}
