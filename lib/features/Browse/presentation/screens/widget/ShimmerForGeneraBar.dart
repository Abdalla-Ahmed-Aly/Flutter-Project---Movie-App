import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForGeneraBar extends StatelessWidget {
  const ShimmerForGeneraBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[500]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(

          children: List.generate(10, (index) {
            return Container(
              height: screenSize.height*.051,
              width: screenSize.width*.24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(16),
              ),
            );
          }),
        ),
      ),
    );
  }
}
