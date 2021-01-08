import 'package:currency_converter/core/models/currency.dart';
import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:currency_converter/ui/custom_widget/currency_text.dart';
import 'package:currency_converter/ui/page/currency_selector_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class CurrencySelectorView extends StatefulWidget {
  @override
  _CurrencySelectorViewState createState() => _CurrencySelectorViewState();
}

class _CurrencySelectorViewState extends State<CurrencySelectorView>
    with SingleTickerProviderStateMixin {

  CurrencyViewModel _viewModel;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _changeButton() {
    return FlatButton(
      onPressed: () {
        if (_viewModel.listToCompare != null ||
            _viewModel.listToCompare.length > 1) {
          _animationController.forward().whenComplete(() {
            _animationController.reset();
            _viewModel.changeCurrencyPositions();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        child: Icon(Icons.autorenew),
        builder: (ctx, widget) {
          return Transform.rotate(
            angle: _animationController.value * math.pi,
            child: widget,
          );
        },
      ),
    );
  }

  Future<Currency> pushCurrencySelectorPage() async {
    var currency = await Navigator.pushNamed(context, "/selector");
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<CurrencyViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FlatButton(
            onPressed: () => pushCurrencySelectorPage().then((currency) {
              if(currency != null) {
                _viewModel.updateCurrenciesSelected(
                    index: 0, title: currency.acronym);
                _viewModel.updateValues(index: 0, value: _viewModel.value0);
              }
            }),
            child: CurrencyText(
                text: _viewModel.listToCompare.elementAt(0) == null
                    ? "Tap here to choose a currency"
                    : _viewModel.listToCompare.first),
          ),
        ),
        _changeButton(),
        Expanded(
          child: FlatButton(
            onPressed: () => pushCurrencySelectorPage().then((currency) {
              if(currency != null) {
                _viewModel.updateCurrenciesSelected(
                    index: 1, title: currency.acronym);
                _viewModel.updateValues(index: 0, value: _viewModel.value0);
              }
            }),
            child: CurrencyText(
                text: _viewModel.listToCompare.elementAt(1) == null
                    ? "Tap here to choose another one"
                    : _viewModel.listToCompare.last),
          ),
        ),
      ],
    );
  }
}
