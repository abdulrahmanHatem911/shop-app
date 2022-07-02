// ignore_for_file: avoid_print
import 'package:application_1/shop_app/screens/login/shop_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constant/color/theme_screen.dart';
import '../../constant/constant_screen.dart';
import '../../constant/Netowrk/locale/cash_helper.dart';
import '../Components/onboarding_data.dart';

// the varible to controll the last page
bool isLast = false;
// ده علشان تيحفظ البيانات و ميخليش الصفحه الي في الاول تظهر تاني
void submit(context) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value) {
      navigateToFinish(
        context,
        const ShopLoginScreen(),
      );
    }
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // controller fotr page view
  var boardingController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Boarding Screen'),
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: defultColor,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (index) {
                  if (index == screen.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('Is Last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('Is not Last');
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(screen[index]),
                itemCount: screen.length,
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: screen.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defultColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    dotColor: Colors.grey,
                    expansionFactor: 4.0,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                      print('navigate done');
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 650),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
