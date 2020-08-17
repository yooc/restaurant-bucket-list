import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_bucket_list/models/restaurant.dart';
import 'package:restaurant_bucket_list/restaurantList.dart';

// API KEY
const String ZOMATO_API_KEY = 'Your API Key';

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
    const url =
        'https://developers.zomato.com/api/v2.1/search?q=&lat=21.28277780&lon=-157.829444405';

    // Create storage
    final _storage = new FlutterSecureStorage();
    await _storage.write(key: 'zomatoApiKey', value: ZOMATO_API_KEY);
    String value = await _storage.read(key: 'zomatoApiKey');

    final response = await http.get(url, headers: {'user-key': value});

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)['restaurants'] as List;
      return jsonData.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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