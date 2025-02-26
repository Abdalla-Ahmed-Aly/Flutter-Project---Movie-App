import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/customButton.dart';

import '../../../../core/widgets/tab_bar_icon.dart';
import '../../../../theme/apptheme.dart';

class ProfileTab extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Column(

      children: [
        Container(
          padding: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
              color: AppTheme.gray
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(

                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("assets/Avatar/gamer1.png"),
                          SizedBox(height: 15,),
                          Text("Marwan Atef",style: textTheme.displaySmall)


                        ],

                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("12",style: textTheme.displayLarge),
                          SizedBox(height: 15,),
                          Text("Watch List",style: textTheme.displayMedium)


                        ],

                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("10",style: textTheme.displayLarge),
                          SizedBox(height: 15,),
                          Text("History",style:  textTheme.displayMedium)


                        ],

                      ),
                    ),



                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 23,horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(flex:3,child: CustomButton(buttonTitle: "Edit Profile", buttonColor: AppTheme.primary, onPressed: (){},fontColor: AppTheme.black,buttonTitleStyle: textTheme.titleMedium,)),
                      SizedBox(width: 10,),
                      Expanded(child: CustomButton(buttonTitle: "Exit", buttonColor: AppTheme.red, onPressed: (){},fontColor: AppTheme.white,buttonTitleStyle:textTheme.titleMedium)),




                    ],

                  ),
                ),
                SizedBox(
                  height: 10,

                ),
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                      indicatorColor: AppTheme.primary,
                      indicatorSize:TabBarIndicatorSize.tab ,
                      labelPadding:const EdgeInsets.only(bottom: 17),
                      indicatorWeight: 3,

                      tabs: [
                        TabBarIcon(iconName: "watchlist", label: "Watch List"),
                        TabBarIcon(iconName: "file", label: "History"),



                      ]),
                ),



              ],

            ),
          ),
        ),
        Expanded(child: Image.asset("assets/images/login_screen_header.png"),)
      ],
    );
  }
}
