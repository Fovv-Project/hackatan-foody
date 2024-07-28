import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/api/api_service.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';
import 'package:hackatan_ui/widget/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Restaurant>>? futureReview;

  Future<List<Restaurant>> loadReview() async {
    final List<Restaurant> response = await ApiService().getRestaurant();
    return response;
  }

  @override
  void initState() {
    super.initState();
    futureReview = loadReview();
  }

  void updateFutureReview(String query) {
    setState(() {
      futureReview = ApiService().getSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Search(onSearch: updateFutureReview),
            ),
            FutureBuilder<List<Restaurant>>(
              future: futureReview,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data == null || data.isEmpty) {
                    return const Text('Data tidak ditemukan');
                  }
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(restaurant: data[index]);
                      },
                    ),
                  );
                } else {
                  return const Text('No data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  final Function(String) onSearch;

  Search({required this.onSearch});
  final TextEditingController _controller = TextEditingController();
  Future<dynamic>? futureReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 64, 64, 64),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          onSearch(_controller.text);
        },
      ),
    );
  }
}
