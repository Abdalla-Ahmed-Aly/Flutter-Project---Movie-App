class OnboardingModel {
  String teaser;
  String? description;
  String imagePath;

  OnboardingModel(
      {required this.teaser, this.description, required this.imagePath});

  static List<OnboardingModel> boards = [
    OnboardingModel(
      teaser: 'Find Your Next Favorite Movie Here',
      description:
          'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      imagePath: '1',
    ),
    OnboardingModel(
      teaser: 'Discover Movies',
      description:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      imagePath: '2',
    ),
    OnboardingModel(
      teaser: 'Explore All Genres',
      description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      imagePath: '3',
    ),
    OnboardingModel(
      teaser: 'Create Watchlists',
      description:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      imagePath: '4',
    ),
    OnboardingModel(
      teaser: 'Rate, Review, and Learn',
      description:
          'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      imagePath: '5',
    ),
    OnboardingModel(
      teaser: 'Start Watching Now',
      imagePath: '6',
    ),
  ];
}
