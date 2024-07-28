import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page', arguments: restaurant);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/image/restaurant_image.jpeg',
              width: 100,
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange[200],
                          size: 20,
                        ),
                        const Text('4.7'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
