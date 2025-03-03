import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildLoadShimmerMoviesSeeMore extends StatelessWidget {
  const BuildLoadShimmerMoviesSeeMore({super.key});

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
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.023),
            ),
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(screenWidth * 0.023),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.021,
                  left: screenWidth * 0.023,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[500]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      width: screenWidth * 0.116,
                      height: screenHeight * 0.032,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.023),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
