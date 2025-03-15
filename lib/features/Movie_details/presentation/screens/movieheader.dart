import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieHeader extends StatefulWidget {
  const MovieHeader({
    super.key,
    required this.screenHeight,
    required this.textTheme,
    required this.imageurl,
    required this.rating,
    required this.likes,
    required this.timecount,
    required this.title,
    required this.releaseDate,
    required this.screenwidth,
    required this.uRL,
  });

  final double screenHeight;
  final double screenwidth;
  final TextTheme textTheme;
  final String imageurl;
  final double rating;
  final int likes;
  final int timecount;
  final String title;
  final int releaseDate;
  final String uRL;

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  bool isBookmarked = false;

  Future<void> openMovieWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(
      uri,
    )) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: widget.screenHeight * 0.64,
            width: double.infinity,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.black.withOpacity(0.5),
                    AppTheme.black,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Image.network(
                widget.imageurl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/failureloading.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity);
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                      icon: isBookmarked
                          ? Icon(
                              Icons.bookmark_rounded,
                              size: 30,
                              color: AppTheme.white,
                            )
                          : Icon(
                              Icons.bookmark_outline_rounded,
                              size: 30,
                              color: AppTheme.white,
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.screenHeight * 0.175,
              ),
              InkWell(
                onTap: () {
                  openMovieWebsite(widget.uRL);
                },
                child: Image.asset(
                  'assets/images/displaybutton.png',
                ),
              ),
              SizedBox(
                height: widget.screenHeight * 0.15,
              ),
              Text(
                widget.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.releaseDate}',
                style: widget.textTheme.displaySmall?.copyWith(
                  color: AppTheme.gray,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomButton(
                  buttonTitle: 'Watch',
                  buttonColor: AppTheme.red,
                  fontColor: AppTheme.white,
                  onPressed: () {
                    openMovieWebsite(widget.uRL);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.screenwidth * 0.30,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.gray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/heart.png',
                            height: 25,
                            width: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${widget.likes}',
                            style: widget.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: widget.screenwidth * 0.28,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.gray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/clock.png',
                            height: 25,
                            width: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${widget.timecount}',
                            style: widget.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: widget.screenwidth * 0.28,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.gray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/star.png',
                            height: 25,
                            width: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${widget.rating}',
                            style: widget.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
