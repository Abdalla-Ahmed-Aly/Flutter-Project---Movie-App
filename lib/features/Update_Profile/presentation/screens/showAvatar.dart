import 'package:flutter/material.dart';
import 'package:movieapp/features/Update_Profile/data/models/avatar_model.dart';
import 'package:movieapp/theme/apptheme.dart';

class ShowAvatar extends StatelessWidget {
  final int selectedAvatarIndex;
  final Function(int) onAvatarSelected;

  ShowAvatar(
      {required this.selectedAvatarIndex, required this.onAvatarSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      height: 370,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: Avatar.avatarPaths.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedAvatarIndex == index;

          return GestureDetector(
            onTap: () {
              onAvatarSelected(index);
              Navigator.pop(context, index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primary.withOpacity(0.7)
                    : AppTheme.gray,
                border: Border.all(color: Colors.yellow, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Avatar.avatarPaths[index].imagePath,
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
