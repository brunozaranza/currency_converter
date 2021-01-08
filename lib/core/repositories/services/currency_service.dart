import 'package:currency_converter/core/models/api_response_live_currencies.dart';
import 'package:currency_converter/core/models/api_response_supported_currencies.dart';
import 'package:currency_converter/core/models/base_api_response.dart';
import 'package:currency_converter/core/repositories/services/base_service.dart';

class CurrencyService extends BaseService {

  static final String _api = "http://api.currencylayer.com";

  static Future<BaseApiResponse<ApiResponseSupportedCurrencies>>
          getAllSupported({bool forceUpdate = false}) async {

    return BaseService.request<ApiResponseSupportedCurrencies>(
        url: "$_api/list",
        validHours: 24*7,
        forceUpdate: forceUpdate
    );
  }

  static Future<BaseApiResponse<ApiResponseLiveCurrencies>>
          getAllLive({bool forceUpdate = false}) async {

    return BaseService.request<ApiResponseLiveCurrencies>(
        url: "$_api/live",
        validHours: 2,
        forceUpdate: forceUpdate
    );
  }
}
