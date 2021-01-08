class ApiResponseSupportedCurrencies {

  Map<String, dynamic> currencies;

  ApiResponseSupportedCurrencies({this.currencies});

  ApiResponseSupportedCurrencies.fromJson(Map<String, dynamic> json) {
    currencies = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['currencies'] = this.currencies;
    return data;
  }
}