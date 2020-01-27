import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_bucket_list/models/restaurant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Restaurant> restaurants;

  @override
  void initState() {
    super.initState();
    this.fetchRestaurantData();
  }

  Future<List<Restaurant>> fetchRestaurantData() async {
    // TODO: Need to find way to secure API key
    const url =
        'https://developers.zomato.com/api/v2.1/search?q=&lat=21.28277780&lon=-157.829444405';
    final response = await http
        .get(url, headers: {'user-key': 'Replace with api key'});

    setState(() {
      var jsonData = jsonDecode(response.body)['restaurants'] as List;
      restaurants = jsonData.map((json) => Restaurant.fromJson(json)).toList();
    });
    return restaurants;
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
          child: Text(restaurants[0].name),
          margin: EdgeInsets.all(8.0),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Text(restaurants[0].location.address),
          margin: EdgeInsets.all(8.0),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Text(restaurants[0].userRatings.aggregateRating),
          margin: EdgeInsets.all(8.0),
        ),
      ]),
    );
  }
}
