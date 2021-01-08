import 'package:currency_converter/core/repositories/database/database.dart';
import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:currency_converter/ui/page/currency_selector_page.dart';
import 'package:currency_converter/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrencyViewModel()),
      ],
      child: CurrencyConverterApp(),
    ),
  );}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
