import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.text,
            style: const TextStyle(fontSize: 14),
                      maxLines: 3,
                overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orange[200],
                size: 20,
              ),
              const Text(
                '5 -',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              Text(
                review.sender,
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              )
            ],
          )
        ],
      ),
    );
  }
}
