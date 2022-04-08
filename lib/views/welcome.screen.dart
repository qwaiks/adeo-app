import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skipButton = Align(
      alignment: Alignment.topRight,
      child: Container(
        color: Colors.white,
        child: TextButton(
          child: const Text(
            AppString.skip,
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {},
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.cornerAbs), fit: BoxFit.contain)),
      ),
    );

    final welcomeText = Text(
      AppString.appWelcome,
      style: TextStyle(fontWeight: FontWeight.bold),
    );

    final subscriptionText = Text(AppString.subscriptionPrompt);

    final button = CustomButton(
      isOutline: true,
      onPressed: () {},
    );

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          skipButton,
          verticalSpacer(),
          welcomeText,
          verticalSpacer(),
          subscriptionText,
          verticalSpacer(),
          button
        ],
      )),
    );
  }
}
