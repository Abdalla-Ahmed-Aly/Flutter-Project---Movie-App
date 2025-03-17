import 'package:movieapp/core/widgets/movieContainerShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/widgets/listView_movies_shimmer.dart';
import '../../../../theme/apptheme.dart';

class CategoryMoviesShimmer extends StatelessWidget {
  CategoryMoviesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.05,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(
                          Icons.arrow_forward,
                          size: screenWidth * 0.045,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        BuildLoadShimmerMovies()
      ],
    );
  }
}
