import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/providers/question.provider.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:adeo_app/shared_widget/option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionProvider vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = context.read<QuestionProvider>();
    vm.initProvider(context: context);
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<QuestionProvider>();
    final time = StreamBuilder<int>(
      stream: vm.stopWatchTimer.rawTime,
      initialData: vm.stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(
          value,
          hours: false,
          milliSecond: false,
        );
        return Container(
          child: Text(
            displayTime,
            style: TextStyle(
              fontSize: 28,
              color: AppColors.background01,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    final timer = Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          SvgPicture.asset(AppImages.cornerAbs),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: time,
            ),
          )
        ],
      ),
    );

    final top = Stack(
      children: [
        Container(
          height: 90,
          child: vm.isLoading
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.questionsList?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var selected = vm.questionNumber == index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: selected ? 40 : 29,
                                  color: Colors.white),
                            ),
                          ),
                          Visibility(
                            child: Container(
                              height: 5,
                              width: 50,
                              color: Colors.white,
                            ),
                            visible: selected,
                          )
                        ],
                      ),
                    );
                  }),
          color: AppColors.background01,
        ),
        timer,
      ],
    );

    final questionText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: vm.isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.white,
              child: ListTile(
                  title: Container(
                    color: Colors.white,
                    height: 30.0,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    height: 20.0,
                  )))
          : Text(
              vm.question?.text ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
    );

    final images = Visibility(
      child: Container(
        height: 110,
        color: Colors.grey,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: vm.isLoading ? 3 : vm.images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, item) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: vm.isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.white.withOpacity(0.5),
                        child: Container(
                          width: 130,
                          height: 105,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://picsum.photos/200/300',
                          width: 130,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                      ),
              );
            }),
      ),
      visible: vm.images.length > 0 || vm.isLoading,
    );

    final options = vm.isLoading
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.1),
                highlightColor: Colors.white,
                child: ListTile(
                  title: Container(
                    color: Colors.white,
                    height: 30.0,
                  ),
                )))
        : CustomOptionList(
            list: vm.question?.answers?.map((e) => e.toJson())?.toList()?? [],
            itemValue: 'id',
            itemLabel: 'text',
            selectedValue: vm.selectedAnswer,
            onChanged: vm.onAnswerSelected,
          );

    final button = CustomButton(
      isOutline: false,
      text: 'Next',
      onPressed: () => vm.checkAnswer(),
    );

    final questionsView = Column(
      children: [
        questionText,
        verticalSpacer(space: 30),
        images,
        verticalSpacer(),
        options
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade700,
          child: Column(
            children: [
              top,
              Expanded(
                child: ListView(
                  children: [
                    verticalSpacer(space: 40),
                    questionsView,
                    verticalSpacer(space: 40),
                  ],
                ),
              ),
              button
            ],
          ),
        ),
      ),
    );
  }
}
