import 'package:json_annotation/json_annotation.dart';
part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
//  var name: String
//  var location: LocationDetails
//  var cuisines: String
//  var average_cost_for_two: Int
//  var user_rating: Ratings

  Restaurant(this.name, this.cuisines, this.averageCostForTwo);

  String name;
  String cuisines;
  @JsonKey(name: 'average_cost_for_two')
  int averageCostForTwo;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
