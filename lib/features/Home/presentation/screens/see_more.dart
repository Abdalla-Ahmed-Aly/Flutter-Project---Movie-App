import 'package:flutter/material.dart';

import '../../../../theme/apptheme.dart';

class SeeMore extends StatelessWidget {
  static const String routeName = "seemore";
  const SeeMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'No genres available',
            style: TextStyle(
                fontSize: 20,
                color: AppTheme.white,
                fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 10),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          " ⭐",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
