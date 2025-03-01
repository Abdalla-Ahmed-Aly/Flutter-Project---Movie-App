import 'package:flutter/material.dart';

import '../../../../core/widgets/cutomTextFormField.dart';
import '../../../../core/widgets/movie_item.dart';

class SearchTab extends StatefulWidget {

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {

    List<String> searchMovieResults = [];
    List<String> movieList = ["Marvel","Dc","mc"];
    void onQueryChanged(String query) {

      searchMovieResults =movieList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
      });




    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 21,left: 16,right: 16),
        child: Column(
          children: [
            TextFormFieldCustom(hintText: "Search",prefixIconPath:"assets/icons/search.svg",onChanged:onQueryChanged,),
            SizedBox(
              height: 12,
            ),
            Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 8), itemBuilder: (context, index) => MovieItem(),itemCount:10))
          ],
        ),
      ),
    );
  }
}