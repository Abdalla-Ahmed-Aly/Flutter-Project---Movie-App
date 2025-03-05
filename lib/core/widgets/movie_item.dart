import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MovieItem extends StatelessWidget {
  String movieImageUrl;
  double movieRating;
  double? screenwidth;
  MovieItem(
      {super.key,
      required this.movieImageUrl,
      required this.movieRating,
      this.screenwidth});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenwidth ?? screenWidth * 0.37,
      margin: EdgeInsets.only(right: screenWidth * 0.023),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movieImageUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/failureloading.png",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity);
              }),
            ),
          ),
          Positioned(
            top: screenHeight * 0.02,
            left: screenWidth * 0.023,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
              ),
              child: Text(
                "$movieRating⭐",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
