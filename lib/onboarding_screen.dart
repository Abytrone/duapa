import 'package:duapa/controllers/onboarding_controller.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final _controller = OnboardingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 0),
              child: PageView.builder(
                onPageChanged: _controller.selectedPageIndex.call,
                controller: _controller.pageController,
                itemCount: _controller.onboardingPages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        width: (constraint.maxWidth < 768) ? 400 : 600,
                        image: AssetImage(
                            _controller.onboardingPages[index].image),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: (constraint.maxWidth < 768)
                            ? MediaQuery.of(context).size.height / 3
                            : MediaQuery.of(context).size.height / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, bottom: 10, top: 20, right: 40),
                              child: Text(
                                _controller.onboardingPages[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize:
                                          (constraint.maxWidth < 768) ? 20 : 35,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40, bottom: 20),
                              child: Text(
                                _controller.onboardingPages[index].text,
                                style: TextStyle(
                                  fontSize:
                                      (constraint.maxWidth < 768) ? 12 : 25,
                                  color: Theme.of(context).brightness ==
                                          lightThemeData(context).brightness
                                      ? kContentColorLightTheme
                                      : kContentColorDarkTheme,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 100,
              left: 50,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 10,
                child: Row(
                  children: List.generate(
                    _controller.onboardingPages.length,
                    (index) => Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: _controller.selectedPageIndex.value == index
                                ? kPrimaryColor
                                : Colors.grey,
                          ),
                          width: _controller.selectedPageIndex.value == index
                              ? 13
                              : 7,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: PrimaryButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
