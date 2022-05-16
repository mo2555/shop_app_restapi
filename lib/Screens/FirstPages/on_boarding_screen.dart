import 'package:flutter/material.dart';
import 'package:shop_app_flutter/Cache/shared_preferences.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Models/boarding_model.dart';
import 'package:shop_app_flutter/Screens/FirstPages/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  List<BoardingModel> boardingDataItem = [
    BoardingModel(
      image: 'assets/images/onBoardingImage.png',
      title: 'On Boarding 1 Title',
      body: 'On Boarding 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoardingImage.png',
      title: 'On Boarding 2 Title',
      body: 'On Boarding 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoardingImage.png',
      title: 'On Boarding 3 Title',
      body: 'On Boarding 3 Body',
    ),
  ];

  PageController boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          textButton(() {
            CacheHelper.setData(key: 'onBoarding', value: true)
                .then((value) => navigatorAndReplace(context, LoginScreen()));
          }, 'SKIP', context),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemCount: 3,
                itemBuilder: (context, index) => customBoardingItem(
                  context,
                  boardingDataItem[index],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingDataItem.length,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: Colors.blue,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  key: const Key('onBoardingButton'),
                  onPressed: () {
                    if (boardingController.page! < 2) {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      CacheHelper.setData(key: 'onBoarding', value: true)
                          .then((value) => navigatorAndReplace(context, LoginScreen()));
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget customBoardingItem(BuildContext context, BoardingModel boardingModel) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              boardingModel.image,
            ),
          ),
        ),
        Text(
          boardingModel.title,
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: 25,
              ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          boardingModel.body,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
