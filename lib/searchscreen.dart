import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_bucket_list/restaurant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Restaurant restaurant;

  @override
  void initState() {
    super.initState();
    this.fetchRestaurantData();
  }

  Future<Restaurant> fetchRestaurantData() async {
    final response = await http.get(
        'https://developers.zomato.com/api/v2.1/restaurant?res_id=17145495',
        headers: {'user-key': 'Replace with api key'});

    setState(() {
      var jsonData = jsonDecode(response.body);
      restaurant = Restaurant.fromJson(jsonData);
    });
    return restaurant;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: 'Search query',
          ),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Text(restaurant.name),
        ),
      ]),
    );
  }
}
