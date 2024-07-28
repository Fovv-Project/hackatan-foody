import 'package:flutter/material.dart';
import 'package:hackatan_ui/data/model/restaurant.dart';
import 'package:hackatan_ui/widget/review_card.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;
  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DetailStateful(restaurant: restaurant));
  }
}

class DetailStateful extends StatefulWidget {
  final Restaurant restaurant;
  const DetailStateful({super.key, required this.restaurant});

  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<DetailStateful> {
  late ScrollController scrollController;
  double offset = 0.0;
  static const double kEffectHeight = 250.0;
  static const double kEffectMinHeight = kToolbarHeight;

  @override
  void initState() {
    scrollController = new ScrollController();
    scrollController.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {
      offset = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    double kMinHeight = kEffectMinHeight + MediaQuery.of(context).padding.top;
    double bannerSize =
        (kEffectHeight - offset * 2.5).clamp(kMinHeight, kEffectHeight);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: const Color.fromARGB(255, 74, 74, 74),
          height: bannerSize,
          child: FlexibleSpaceBar.createSettings(
              maxExtent: kEffectHeight,
              minExtent: kMinHeight,
              currentExtent: bannerSize,
              child: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Opacity(
                  opacity: 0.5,
                  child: Image.network(
                    "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/627c528c-c7b9-4fab-a687-1ebd5907b74b_Go-Biz_20230921_125206.jpeg", // image
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ),
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: bannerSize,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Ayam, Aneka Nasi, Cepat Saji",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "4.7",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 4),
                          child: const Text(
                            "4070 penilaian",
                            style: TextStyle(color: Colors.black45),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 28),
                        child: Column(
                          children: [
                            buildProgressRow(5, 0.9, Colors.orange[200]!),
                            buildProgressRow(4, 0.1, Colors.orange[200]!),
                            buildProgressRow(3, 0.0, Colors.orange[200]!),
                            buildProgressRow(2, 0.0, Colors.orange[200]!),
                            buildProgressRow(1, 0.0, Colors.orange[200]!),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ringkasan Review by AI',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      child: Text(
                        '"${widget.restaurant.reviewSummary}"',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 200,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(31, 132, 132, 132)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                    child: Text(
                                  "Apa kata orang-orang",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                                IconButton(
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  color: Colors.black54,
                                  iconSize: 20,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/review_page',
                                        arguments: widget.restaurant.reviews);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      // ReviewCard(review: widget.res)
                      SizedBox(
                        height: 120,
                        // width: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.restaurant.reviews.length,
                          itemBuilder: (context, index) {
                            return ReviewCard(
                                review: widget.restaurant.reviews[index]);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                }),
            // FavoriteButton()
          ],
        )),
      ],
    );
  }

  Widget buildProgressRow(int label, double value, Color color) {
    return Row(
      children: [
        Text(label.toString()),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 5,
            child: LinearProgressIndicator(
              value: value,
              color: color,
              semanticsLabel: 'Linear progress indicator',
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        });
  }
}
