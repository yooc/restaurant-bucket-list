import 'package:flutter/material.dart';
import 'package:restaurant_bucket_list/models/restaurant.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  RestaurantList({Key key, this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: restaurants.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.amber,
          child: Column(children: <Widget>[
            Text(restaurants[index].name),
            Text(restaurants[index].cuisines),
            Text(
                'Average Cost for Two: \$/${restaurants[index].averageCostForTwo}'),
            Text('Address: ${restaurants[index].location.address}'),
            Text(
                'Rated ${restaurants[index].userRatings.aggregateRating} by ${restaurants[index].userRatings.numberOfReviews} users')
          ]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
