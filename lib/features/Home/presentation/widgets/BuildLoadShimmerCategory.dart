import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildLoadShimmerCategory extends StatelessWidget {
  const BuildLoadShimmerCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[700]!,
          highlightColor: Colors.grey[500]!,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
