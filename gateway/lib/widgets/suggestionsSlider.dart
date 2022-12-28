// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gateway/homeScreen.dart';

// ignore: use_key_in_widget_constructors
class Suggestions extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Suggestions> {
  late PageController _pageController;
  int pageNumber = 0;
  Timer? sliderTime;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 5), (timer) {
      if (pageNumber == 5) {
        pageNumber = 0;
      }
      _pageController.animateToPage(pageNumber,
          duration: const Duration(seconds: 1), curve: Curves.easeInCirc);
      pageNumber++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    sliderTime = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              5,
              (index) => GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNumber == index
                        ? Colors.amberAccent
                        : const Color.fromARGB(255, 246, 244, 237),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                pageNumber = index;
                setState(() {});
              },
              itemBuilder: (_, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return child!;
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                    onPanDown: ((details) {
                      sliderTime?.cancel();
                      sliderTime = null;
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
