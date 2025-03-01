import 'package:flutter/material.dart';
import 'package:movieapp/features/Browse/presentation/screens/tab_bar_for_browse.dart';

import '../../../../core/widgets/movie_item.dart';

class BrowseTab extends StatefulWidget {
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String>generaName=List.generate(10, (index) => "genera${index}",);

  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            DefaultTabController(
                length:generaName.length ,
                child: TabBar(onTap: (index) {
                  if(currentIndex==index)return;
                  currentIndex=index;
                  setState(() {

                  });

                },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabAlignment:TabAlignment.start,
                    padding: EdgeInsets.only(left: 16),
                    labelPadding:  EdgeInsets.only(right: 8),
                    tabs: generaName.map((genera) => TabBarForBrowse(label: genera,isSelected:currentIndex==generaName.indexOf(genera)),).toList())),

            Expanded(child: GridView.builder(padding: EdgeInsets.only(top: 25,right: 16,left: 16),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 8), itemBuilder: (context, index) => MovieItem(),itemCount:10))



          ],


        ),
      ),
    );
  }
}
