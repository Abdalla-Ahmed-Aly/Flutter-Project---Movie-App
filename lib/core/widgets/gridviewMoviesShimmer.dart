import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/movieContainerShimmer.dart';

class BuildLoadShimmerMoviesSeeMore extends StatelessWidget {
  int columnNumber;

  BuildLoadShimmerMoviesSeeMore({
    super.key,
    required this.columnNumber,
  });
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.023),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: screenWidth * 0.023,
          mainAxisSpacing: screenWidth * 0.023,
          childAspectRatio: 0.7,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return MovieContainerShimmer();
        },
      ),
    );
  }
}
