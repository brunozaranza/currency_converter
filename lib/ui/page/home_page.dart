import 'package:currency_converter/core/utils/string_util.dart';
import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:currency_converter/ui/view/currency_selector_view.dart';
import 'package:currency_converter/ui/view/currency_value_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyViewModel _viewModel;

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _body() {
    if (_viewModel.supported == null) {
      _viewModel.fetchAllSupported();
      return Align(
        child: CircularProgressIndicator(),
      );
    } else if (_viewModel.supported.isEmpty) {
      return Align(child: Text("Não foi possível carregar moedas"));
    } else {
      return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CurrencySelectorView(),
              Divider(
                height: 2,
                color: Colors.black54,
              ),
              _viewModel.listToCompare.contains(null)
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Firstly, you need choose what currency wish to converter.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    )
                  : _fields()
            ]),
      );
    }
  }

  Widget _fields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurrencyValueView(index: 0, label: _viewModel.listToCompare.first),
        Divider(height: 2, color: Colors.black54,),
        CurrencyValueView(index: 1, label: _viewModel.listToCompare.last),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
      ),
      body: _body(),
    );
  }
}
