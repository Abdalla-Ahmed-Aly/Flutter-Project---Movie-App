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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
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
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.023),
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
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.025),
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
                                  padding: EdgeInsets.all(screenWidth * 0.014),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.025),
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
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
