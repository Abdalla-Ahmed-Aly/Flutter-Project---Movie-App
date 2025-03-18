import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';

class SummaryAndGenres extends StatelessWidget {
  final int id;
  final String? descriptionIntro;
  final List<String>? genres;

  const SummaryAndGenres({
    Key? key,
    required this.id,
    this.descriptionIntro,
    this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          if (descriptionIntro?.isNotEmpty == true)
            Text(
              descriptionIntro!,
              style: textTheme.titleSmall,
            )
          else
            Text(
              'No available summary',
              style: textTheme.titleSmall,
            ),
          SizedBox(height: 20),
          Text(
            'Genres',
            style: textTheme.displayMedium,
          ),
          SizedBox(height: 10),
          if (genres!.isNotEmpty == true)
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3,
              ),
              itemCount: genres!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppTheme.gray,
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle),
                  child: Center(
                    child: Text(
                      genres![index],
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            )
          else
            Text(
              'No genres available',
              style: textTheme.titleSmall,
            ),
        ],
      ),
    );
  }
}
