import 'package:currency_converter/core/utils/string_util.dart';
import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyValueView extends StatefulWidget {
  final String label;
  final int index;

  CurrencyValueView({@required this.label, @required this.index});

  @override
  _CurrencyValueViewState createState() => _CurrencyValueViewState();
}

class _CurrencyValueViewState extends State<CurrencyValueView> {

  CurrencyViewModel _viewModel;
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<CurrencyViewModel>(context);

    _controller.text = StringUtil.formatToDecimalPlaces(
        decimalPlaces: 2,
        value: widget.index == 0 ? _viewModel.value0 : _viewModel.value1);
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));

    _controller.addListener(() {
      if(_controller.text.isEmpty) {
        _viewModel.clearValues();
      }
    });

    return Container(
      color: Color(0x11111155),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_viewModel.supported[widget.label]),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (text) {
                if (_viewModel.live == null) {
                  _viewModel.fetchAllLive().then((value) =>
                      _viewModel.updateValues(
                          index: widget.index, value: double.parse(text)));
                } else {
                  _viewModel.updateValues(
                      index: widget.index, value: double.parse(text));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
