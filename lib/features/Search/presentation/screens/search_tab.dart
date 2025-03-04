import 'package:flutter/material.dart';

import '../../../../core/widgets/cutomTextFormField.dart';
import '../../../../core/widgets/movie_item.dart';
import '../../../../theme/apptheme.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    List<String> searchMovieResults = [];
    List<String> movieList = ["Marvel", "Dc", "mc"];
    void onQueryChanged(String query) {
      searchMovieResults = movieList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {});
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 21, left: 16, right: 16),
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
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/Dummyimage.png",
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                  top: 13,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.black.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("7.7",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("⭐")
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                    itemCount: 10))
          ],
        ),
      ),
    );
  }
}
