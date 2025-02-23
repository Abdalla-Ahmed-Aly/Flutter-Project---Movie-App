import 'package:flutter/material.dart';

class ShowAvatar extends StatelessWidget {
  final int selectedAvatarIndex;
  final Function(int) onAvatarSelected;

  ShowAvatar(
      {required this.selectedAvatarIndex, required this.onAvatarSelected});

  final List<String> avatarPaths = [
    'assets/Avatar/gamer1.png',
    'assets/Avatar/gamer2.png',
    'assets/Avatar/gamer3.png',
    'assets/Avatar/gamer4.png',
    'assets/Avatar/gamer5.png',
    'assets/Avatar/gamer6.png',
    'assets/Avatar/gamer7.png',
    'assets/Avatar/gamer8.png',
    'assets/Avatar/gamer9.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.all(16),
      height: 400,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: avatarPaths.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedAvatarIndex == index;

          return GestureDetector(
            onTap: () {
              onAvatarSelected(index);
              Navigator.pop(context, index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber[700] : Colors.black,
                border: Border.all(color: Colors.yellow, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  avatarPaths[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
