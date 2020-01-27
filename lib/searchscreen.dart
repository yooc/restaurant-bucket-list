import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_bucket_list/models/restaurant.dart';
import 'package:restaurant_bucket_list/restaurantList.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Restaurant>> restaurants;

  @override
  void initState() {
    super.initState();
    restaurants = _fetchRestaurantData();
  }

  Future<List<Restaurant>> _fetchRestaurantData() async {
    // TODO: Need to find way to secure API key
    const url =
        'https://developers.zomato.com/api/v2.1/search?q=&lat=21.28277780&lon=-157.829444405';
    final response = await http
        .get(url, headers: {'user-key': 'Insert API Key'});

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)['restaurants'] as List;
      return jsonData.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
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
        FutureBuilder<List<Restaurant>>(
          future: restaurants,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return RestaurantList(restaurants: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ]),
    );
  }
}