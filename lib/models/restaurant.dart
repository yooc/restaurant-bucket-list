import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  Restaurant(this.name, this.cuisines, this.averageCostForTwo, this.location,
      this.userRatings);

  String name;
  String cuisines;
  @JsonKey(name: 'average_cost_for_two')
  int averageCostForTwo;
  Location location;
  @JsonKey(name: 'user_rating')
  Ratings userRatings;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json['restaurant']);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable()
class Location {
  Location(this.address);

  String address;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Ratings {
  Ratings(this.aggregateRating, this.numberOfReviews);

  @JsonKey(name: 'aggregate_rating')
  String aggregateRating;
  @JsonKey(name: 'votes')
  int numberOfReviews;

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);

  Map<String, dynamic> toJson() => _$RatingsToJson(this);
}
