import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search query',
        ),
      ),
    );
  }
}
