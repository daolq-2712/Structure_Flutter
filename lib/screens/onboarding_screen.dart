import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../fooderlich_pages.dart';
import '../models/models.dart';

class OnBoardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.onboardingPath,
      key: ValueKey(FooderlichPages.onboardingPath),
      child: const OnBoardingScreen(),
    );
  }

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Getting started'),
          leading: GestureDetector(
            child: const Icon(
              Icons.chevron_left,
              size: 40,
            ),
            onTap: () {
              Navigator.pop(context, true);
            },
          )),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildPages(controller)),
            _buildIndicator(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPages(PageController controller) {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/recommend.png'),
          'Check out weekly recommended recipes and what your friends are cooking!',
        ),
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/sheet.png'),
          'Cook with step by step instructions!',
        ),
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/list.png'),
          'Keep track of what you need to buy',
        ),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: WormEffect(
        activeDotColor: rwColor,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
            child: const Text('Skip'),
            onPressed: () {
              Provider.of<AppStateManager>(context, listen: false)
                  .completeOnBoarding();
            }),
      ],
    );
  }
}
