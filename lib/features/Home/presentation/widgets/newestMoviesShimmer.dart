import 'package:movieapp/core/widgets/movieContainerShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/widgets/listView_movies_shimmer.dart';
import '../../../../theme/apptheme.dart';
import 'categoey_movies_shimmer.dart';

class NewestMoviesShimmer extends StatelessWidget {
  NewestMoviesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: screenHeight,
            child: Shimmer.fromColors(
              baseColor: Colors.black45,
              highlightColor: Colors.black26,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/images/Available Now.png',
                  ),
                ),
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: screenHeight * 0.4,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.6,
                ),
                itemCount: 5,
                itemBuilder: (context, index, realIndex) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: MovieContainerShimmer(width: screenWidth * 0.6),
                  );
                },
              ),
              Center(
                child: SizedBox(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.15,
                    child: Image.asset("assets/images/Watch Now.png")),
              ),
              CategoryMoviesShimmer(),
            ],
          ),
        ],
      ),
    );
  }
}
