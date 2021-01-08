import 'package:currency_converter/core/viewmodels/currency_view_model.dart';
import 'package:currency_converter/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/ui/router.dart';

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
      initialRoute: "/",
      onGenerateRoute: AppRouter.generateRoute,
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
