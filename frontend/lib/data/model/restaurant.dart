import 'dart:convert';

class Restaurant {
  final int id;
  final String name;
  final List<Label> labels;
  final List<Menu> menu;
  final List<Review> reviews;
  final String reviewSummary;

  Restaurant(
      {required this.id,
      required this.name,
      required this.labels,
      required this.menu,
      required this.reviews,
      required this.reviewSummary});

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        reviewSummary: json["review_summary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "review_summary": reviewSummary,
      };

  static List<Restaurant> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((json) => Restaurant.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonArray(List<Restaurant> restaurants) {
    return restaurants.map((restaurant) => restaurant.toJson()).toList();
  }
}

class Menu {
  final int id;
  final String name;
  final String description;
  final int price;
  final String thumbnail;

  Menu({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "thumbnail": thumbnail,
      };
}

class Review {
  final int id;
  final String sender;
  final String text;
  final num rating;
  // final int likes;
  // final String timeInterval;
  // final int totalReview;

  Review({
    required this.id,
    required this.sender,
    required this.text,
    required this.rating,
    // required this.likes,
    // required this.timeInterval,
    // required this.totalReview,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        sender: json["sender"],
        text: json["text"],
        rating: json["rating"],
        // likes: json["likes"],
        // timeInterval: json["timeInterval"],
        // totalReview: json["totalReview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "text": text,
        "rating": rating,
        // "likes": likes,
        // "timeInterval": timeInterval,
        // "totalReview": totalReview,
      };
}

class Label {
  final int id;
  
  final int restaurantId;
  final String text;

  Label({
    required this.id,
    required this.restaurantId,
    required this.text,
  });

  factory Label.fromRawJson(String str) => Label.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        id: json["id"],
        restaurantId: json["RestaurantId"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "RestaurantId": restaurantId,
        "text": text,
      };
}
