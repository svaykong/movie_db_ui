import 'package:flutter/material.dart';

import 'package:movieui_design_starter/utils/colors.dart';
import 'package:movieui_design_starter/widgets/custom_card_thumbnail.dart';

import '../data/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  // items
  List<MovieModel> forYouItemsList = List.of(forYouImages);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateSlider() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      int nextPage = _pageController.page!.round() + 1;

      if (nextPage == forYouItemsList.length) {
        nextPage = 0;
      }

      _pageController.animateToPage(nextPage, duration: const Duration(milliseconds: 800), curve: Curves.linear).then((_) => _animateSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // for items
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top container
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hi, John Doe!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                image: const DecorationImage(
                                  image: NetworkImage('https://image.tmdb.org/t/p/w600_and_h900_bestv2/4vc8wOf2yG9TiXoJpvz2fJHOmHA.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 2.0,
                              top: 2.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kButtonColor,
                                ),
                                height: 10.0,
                                width: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: kSearchbarColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white30,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(fontSize: 18.0, color: Colors.white30),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 5.0,
                    ),
                    child: Text(
                      'For you',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  forYouCardsLayout(forYouItemsList),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: kSearchbarColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: buildPageIndicatorWidget,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bottom navigation bar
          Positioned(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget forYouCardsLayout(List<MovieModel> movieList) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.47,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return CustomCardThumbnail(
            imgAsset: movieList[index].imageAsset.toString(),
          );
        },
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
    );
  }

  // indicators
  List<Widget> get buildPageIndicatorWidget {
    List<Widget> list = [];
    for (int i = 0; i < forYouItemsList.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
