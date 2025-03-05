import 'package:flutter/material.dart';

import '../../../../theme/apptheme.dart';

// ignore: must_be_immutable
class TabBarForBrowse extends StatelessWidget {
  bool isSelected;
  String label;
  TabBarForBrowse({super.key, required this.label, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? null
              : Border.all(width: 2, color: AppTheme.primary)),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: isSelected ? AppTheme.black : AppTheme.primary),
      ),
    );
  }
}
