import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';
import 'package:hackatan_ui/ui/detail_page.dart';
import 'package:hackatan_ui/ui/home_page.dart';
import 'package:hackatan_ui/ui/review_page.dart';
import 'package:hackatan_ui/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Grab Clone',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          // useMaterial3: true,
        ),
        initialRoute: '/search_page',
        routes: {
          '/home_page': (context) => const HomePage(),
          '/search_page': (context) => const SearchPage(),
          // '/detail_page': (context) => const DetailPage(),
          '/detail_page': (context) {
            final res =
                ModalRoute.of(context)?.settings.arguments as Restaurant;
            return DetailPage(
              restaurant: res,
            );
            // );
          },
          '/review_page': (context) {
            final res =
                ModalRoute.of(context)?.settings.arguments as List<Review>;
            return ReviewPage(reviews: res);
          },
        });
  }
}
