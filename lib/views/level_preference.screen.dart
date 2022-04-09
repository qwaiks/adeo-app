import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:flutter/material.dart';

class LevelPreferenceScreen extends StatelessWidget {
  const LevelPreferenceScreen({Key key}) : super(key: key);

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

    final selectText = Text(
      AppString.selectLevel,
      style: TextStyle(fontSize: 29),
    );

    final options = Container();



    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              skipButton,
              verticalSpacer(),
              Container(
                child: Column(
                  children: [
                    selectText,
                    verticalSpacer(),
                    options
                  ],
                ),
                decoration: const  BoxDecoration(
                  image:  DecorationImage(
                    image: AssetImage(
                      AppImages.levelAbs
                    ),
                    fit:  BoxFit.cover
                  )
                ),
              )
            ],
          ),
          color: AppColors.background02,
        ),
      ),
    );
  }
}
