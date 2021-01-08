import 'package:connectivity/connectivity.dart';
import 'package:currency_converter/core/models/api_response_from_database.dart';
import 'package:currency_converter/core/models/base_api_response.dart';
import 'package:currency_converter/core/repositories/database/database.dart';
import 'package:currency_converter/core/utils/date_util.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BaseService<T> {

  static Future<BaseApiResponse<T>> request<T>({@required String url,
    bool forceUpdate = false, List<String> params, int validHours}) async {

    url = "$url?access_key=b086259f3776f4360692c1b0351d44ec";

    if(params != null) {
      for(String param in params) url = "$url&$param";
    }

    ApiResponseFromDatabase jsonResponse = await Database.getJson(fromKey: url);

    if (!DateUtil.checkIsValid(
        date: jsonResponse.lastUpdate, validHours: validHours)) {
      forceUpdate = true;
    }

    var connectivityResult = await (Connectivity().checkConnectivity());

    if((forceUpdate || jsonResponse == null)
        && connectivityResult != ConnectivityResult.none) {

        var response = await http.get(url);

        if (response.statusCode == 200) {
          Database.saveData(url, response.body);
          jsonResponse.json = response.body;
          jsonResponse.lastUpdate = DateUtil.parseDateToString(DateTime.now());
        } else {
          if (jsonResponse.json == null) {
            return BaseApiResponse.fromJson(null, error: "Não foi possível carregar dados."
                " Código do erro ${response.statusCode}");
          }
        }
    }

    var json = convert.jsonDecode(jsonResponse.json);

    BaseApiResponse<T> model = BaseApiResponse<T>.fromJson(json);

    if(connectivityResult == ConnectivityResult.none)
      model.msgError = "Verifique sua conexão e tente mais tarde.";

    return model;
  }
}