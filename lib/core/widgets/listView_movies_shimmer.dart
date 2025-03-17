import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'movieContainerShimmer.dart';

class BuildLoadShimmerMovies extends StatelessWidget {
  const BuildLoadShimmerMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.268,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.023),
        itemCount: 10,
        itemBuilder: (context, index) {
          return MovieContainerShimmer();
        },
      ),
    );
  }
}
