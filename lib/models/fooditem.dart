import 'package:flutter/foundation.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
    id: 1,
    title: "Beach BBQ Burger",
    hotel: "Canteen",
    price: 30,
    imgUrl:
        "https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
  ),
  FoodItem(
    id: 2,
    title: "Kick Ass Burgers",
    hotel: "Canteen",
    price: 40,
    imgUrl:
        "https://b.zmtcdn.com/data/pictures/chains/8/18427868/1269c190ab2f272599f8f08bc152974b.png",
  ),
  FoodItem(
    id: 3,
    title: "Supreme Pizza Burger",
    hotel: "Canteen",
    price: 100,
    imgUrl: "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),
  FoodItem(
    id: 4,
    title: "Chilly Cheeze Burger",
    hotel: "Canteen",
    price: 14,
    imgUrl: "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),
  /*FoodItem(
    id: 5,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14,
    imgUrl: "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),
  FoodItem(
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14,
    imgUrl:
        "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),*/
]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}