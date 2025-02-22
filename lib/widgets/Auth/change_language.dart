import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
    bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnglish = !isEnglish;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.amber, width: 3),
        ),
        child: Stack(
          children: [
            Align(
              alignment:
                  isEnglish ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isEnglish
                        ? Border.all(color: Colors.amber, width: 2)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: SvgPicture.asset('assets/icons/en.svg',
                      width: 30, height: 30),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: !isEnglish
                        ? Border.all(color: Colors.amber, width: 2)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: SvgPicture.asset('assets/icons/eg.svg',
                      width: 30, height: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
