import 'package:flutter/material.dart';
import 'package:movieapp/features/Home/presentation/screens/Category_and_movies.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Image.asset("assets/images/Available Now.png")),
        Center(child: Image.asset("assets/images/Watch Now.png")),
        CategoryAndMovies()
      ])),
    );
  }
}
