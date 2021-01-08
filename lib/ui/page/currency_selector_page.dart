import 'package:currency_converter/core/models/currency.dart';
import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:currency_converter/ui/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelectorPage extends StatefulWidget {
  @override
  _CurrencySelectorPageState createState() => _CurrencySelectorPageState();
}

class _CurrencySelectorPageState extends State<CurrencySelectorPage> {
  CurrencyViewModel _viewModel;
  TextEditingController _controller = TextEditingController();
  Map<String, dynamic> _searchResult;

  Widget _body() {
    if (_viewModel.supported == null) {
      _viewModel.fetchAllSupported();
      return Align(
        child: CircularProgressIndicator(),
      );
    } else if (_viewModel.supported.isEmpty) {
      return Align(child: Text("Sorry. Wasn't possible load currencies."));
    } else {
      if (_searchResult == null) _onSearchTextChanged("");

      return Column(
        children: [
          SearchView(
              controller: _controller,
              onChanged: _onSearchTextChanged,
              clearPressed: () {
                _controller.clear();
                _onSearchTextChanged('');
              }),
          _searchResult.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("This currency is not found."),
                )
              : _listView(),
        ],
      );
    }
  }

  _onSearchTextChanged(String text) async {
    if (_searchResult == null) _searchResult = {};

    _searchResult.clear();

    for (MapEntry<String, dynamic> map
        in _viewModel.supported.entries.toList()) {
      if (map.key.toUpperCase().contains(text.toUpperCase()) ||
          map.value.toString().toUpperCase().contains(text.toUpperCase())) {
        _searchResult[map.key] = map.value;
      }
    }
    setState(() {});
  }

  _listView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (_, index) {
          MapEntry<String, dynamic> map =
          _searchResult.entries.elementAt(index);
          return InkWell(
            onTap: () => Navigator.pop(context,
                Currency(acronym: map.key, name: map.value)),
            child: ListTile(
              title: Text("[${map.key}] ${map.value.toString()}"),
              leading: Icon(Icons.attach_money),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a currency"),
      ),
      body: _body(),
    );
  }
}
