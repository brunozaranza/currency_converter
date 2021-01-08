class ApiResponseLiveCurrencies {

  Map<String, dynamic> currencies;
  String source;

  ApiResponseLiveCurrencies({this.currencies, this.source});

  ApiResponseLiveCurrencies.fromJson(Map<String, dynamic> json, String s) {
    currencies = json;
    source = s;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['quotes'] = this.currencies;
    return data;
  }
}