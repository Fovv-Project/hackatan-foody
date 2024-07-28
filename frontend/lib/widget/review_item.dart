import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircularUserIcon(),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.sender,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('11 ulasan')
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange[200],
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange[200],
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange[200],
                  size: 20,
                ),
                // Container(
                //   padding: const EdgeInsets.only(left: 8),
                //   child: Text(
                //     "sad",
                //     // review.timeInterval,
                //     style: const TextStyle(fontSize: 14),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              review.text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.black45,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                child:
                    Text('41', style: const TextStyle(color: Colors.black45)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CircularUserIcon extends StatelessWidget {
  const CircularUserIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 35.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
