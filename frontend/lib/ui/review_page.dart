import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';
import 'package:hackatan_ui/widget/review_item.dart';

class ReviewPage extends StatefulWidget {
  final List<Review> reviews;
  const ReviewPage({super.key, required this.reviews});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai dan Ulasan'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            return ReviewItem(review: widget.reviews[index]);
          },
        ),
      ),
    );
  }
}
