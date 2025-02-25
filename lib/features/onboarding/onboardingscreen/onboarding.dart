import 'package:flutter/material.dart';
import 'package:movieapp/features/onboarding/models/onboardingmodel.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/core/widgets/customButton.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOnBoardingBottomSheet(
          rightnowindex, context, controller, onboardingmodels);
    });

    showWidgets = List.generate(onboardingmodels.length, (index) => false);
    showWidgetWithDelay(0);
  }

  void showWidgetWithDelay(int pageIndex) {
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          showWidgets[pageIndex] = true;
        });
      }
    });
  }

  int rightnowindex = 0;
  List<OnboardingModel> onboardingmodels = OnboardingModel.boards;
  PageController controller = PageController();
  List<bool> showWidgets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingmodels.length,
        controller: controller,
        onPageChanged: (index) {
          rightnowindex = index;
          if (!showWidgets[index]) {
            showWidgetWithDelay(index);
          }

          Future.delayed(
            Duration(milliseconds: 350),
            () => showOnBoardingBottomSheet(
                rightnowindex, context, controller, onboardingmodels),
          );

          setState(() {});
        },
        itemBuilder: (context, index) {
          return showWidgets[index]
              ? Image.asset(
                  'assets/images/moviesposter${onboardingmodels[index].imagePath}.png',
                  fit: BoxFit.fill,
                )
              : CircularProgressIndicator(
                  color: Colors.transparent,
                );
        },
      ),
    );
  }
}

void showOnBoardingBottomSheet(int rightnowindex, BuildContext screenContext,
    PageController controller, List<OnboardingModel> onboardingmodels) {
  Theme.of(screenContext).textTheme;
  showModalBottomSheet(
    backgroundColor: rightnowindex == 0 ? Colors.transparent : AppTheme.black,
    context: screenContext,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(45),
      ),
    ),
    enableDrag: false,
    isDismissible: false,
    builder: (modelContext) => PopScope(
      canPop: false,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              onboardingmodels[rightnowindex].teaser,
              style: Theme.of(screenContext).textTheme.displayLarge,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (rightnowindex != 5)
              Text(
                onboardingmodels[rightnowindex].description!,
                style: Theme.of(screenContext)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.gray),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            CustomButton(
              buttonTitle: rightnowindex == 0
                  ? 'Explore Now'
                  : rightnowindex == 5
                      ? 'Finish'
                      : 'Next',
              buttonColor: AppTheme.primary,
              buttonTitleStyle:
                  Theme.of(screenContext).textTheme.titleLarge?.copyWith(
                        color: AppTheme.black,
                      ),
              onPressed: () {
                if (rightnowindex < 5) {
                  rightnowindex++;

                  controller.animateToPage(
                    rightnowindex,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(modelContext);
                } else {
                  LocalStorageServices.setbool(
                      LocalStorageKeys.runforthefirsttime, true);
                  Navigator.of(screenContext).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            if (rightnowindex != 0 && rightnowindex != 1)
              CustomButton(
                buttonTitle: 'Back',
                buttonColor: AppTheme.black,
                borderSideColor: AppTheme.primary,
                buttonTitleStyle:
                    Theme.of(screenContext).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primary,
                        ),
                onPressed: () {
                  rightnowindex--;
                  controller.animateToPage(
                    rightnowindex,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(modelContext);
                },
              ),
          ],
        ),
      ),
    ),
  );
}
