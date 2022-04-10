import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var router = locator<RouterService>();

    final skipButton = Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          SvgPicture.asset(AppImages.cornerAbs),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  AppString.skip,
                  style: TextStyle(color: AppColors.background01, fontSize: 18),
                ),
                onPressed: () => router.navigateTo(AppRoutes.questionRoute, args: {
                  'selectedLevel': 1,
                  'selectedClass': 1
                })
              ),
            ),
          )
        ],
      ),
    );

    const welcomeText = Text(
      AppString.appWelcome,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    );

    final subscriptionText = Text.rich(
      TextSpan(text: 'You currently have\n', children: [
        TextSpan(
            text: 'NO'.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const TextSpan(text: ' Subscription\n\n\n'),
        const TextSpan(text: 'First Take a '),
        TextSpan(
            text: 'Diagnostic Test\n'.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const TextSpan(text: ' to determine the right course \nfor you'),
      ]),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );

    final button = CustomButton(
      text: AppString.next,
      isOutline: true,
      onPressed: () => router.navigateTo(AppRoutes.levelRoute),
    );

    return Scaffold(
      body: SafeArea(
          child: Container(
        color: AppColors.background01,
        child: ListView(
          children: [
            skipButton,
            verticalSpacer(space: 54),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  welcomeText,
                  verticalSpacer(space: 28),
                  subscriptionText,
                  verticalSpacer(space: 65),
                  button
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
