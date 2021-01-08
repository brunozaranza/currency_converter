import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  TextEditingController controller;
  Function(String) onChanged;
  Function() clearPressed;

  SearchView({
    @required this.controller,
    @required this.onChanged,
    @required this.clearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search),
            title: new TextField(
              controller: controller,
              decoration: new InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onChanged,
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel),
              onPressed: clearPressed,
            ),
          ),
        ),
      ),
    );
  }
}
