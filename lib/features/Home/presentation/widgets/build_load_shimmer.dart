import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          return Container(
            width: screenWidth * 0.372,
            margin: EdgeInsets.only(right: screenWidth * 0.023),
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
