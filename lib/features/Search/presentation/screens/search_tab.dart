import 'package:flutter/material.dart';

import '../../../../core/widgets/cutomTextFormField.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<String> searchMovieResults = [];
  List<String> movieList = ["Marvel", "Dc", "mc"];
  void onQueryChanged(String query) {
    searchMovieResults = movieList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 21, right: 16, left: 16),
        child: Column(
          children: [
            TextFormFieldCustom(
              hintText: "Search",
              prefixIconPath: "assets/icons/search.svg",
              onChanged: onQueryChanged,
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.023,
                mainAxisSpacing: screenWidth * 0.023,
                childAspectRatio: screenWidth / (screenHeight * 0.7),
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          "assets/images/Dummyimage.png",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.023,
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.011),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.025),
                            ),
                            child: Text(
                              "7.7 ⭐",
                              style: TextStyle(
                                fontSize: screenWidth * 0.032,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
