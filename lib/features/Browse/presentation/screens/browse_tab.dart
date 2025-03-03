import 'package:flutter/material.dart';
import 'package:movieapp/features/Browse/presentation/screens/tab_bar_for_browse.dart';

import '../../../../core/widgets/movie_item.dart';
import '../../../../theme/apptheme.dart';

class BrowseTab extends StatefulWidget {
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String> generaName = List.generate(
    10,
        (index) => "genera${index}",
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            DefaultTabController(
                length: generaName.length,
                child: TabBar(
                    onTap: (index) {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      setState(() {});
                    },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.only(left: 16),
                    labelPadding: EdgeInsets.only(right: 8),
                    tabs: generaName
                        .map(
                          (genera) => TabBarForBrowse(
                          label: genera,
                          isSelected:
                          currentIndex == generaName.indexOf(genera)),
                    )
                        .toList())),
            Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.only(top: 25, right: 16, left: 16),
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
