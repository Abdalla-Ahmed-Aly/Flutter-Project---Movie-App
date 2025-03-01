import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';
class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/images/Dummyimage.png",width: double.infinity,height: double.infinity,fit: BoxFit.fill,)),
          Positioned(top: 13,left: 10,child: Container(
            padding: EdgeInsets.symmetric(vertical: 6,horizontal: 8),
            decoration: BoxDecoration(
              color: AppTheme.black.withOpacity(.7),
              borderRadius: BorderRadius.circular(10),

            ),
            child: Row(
              children: [
                Text("7.7",style: Theme.of(context).textTheme.titleSmall),
                SizedBox(
                  width: 5,
                ),
                Text("⭐")


              ],


            ),

          )


          )


        ],

      ),
    );
  }
}