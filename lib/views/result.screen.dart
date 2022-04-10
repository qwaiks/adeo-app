import 'dart:developer';

import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/models/stats.dart';
import 'package:adeo_app/providers/question.provider.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  QuestionProvider vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = context.read<QuestionProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(fontSize: 15, color: Colors.white);
    var router = locator<RouterService>();

    final top = Container(
        color: AppColors.background01,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                _buildRow(Text(
                  'Score',
                  style: headerStyle,
                )),
                _buildRow(Text(
                  'Rank',
                  style: headerStyle,
                )),
                _buildRow(Text(
                  'Time taken',
                  style: headerStyle,
                )),
              ],
            ),
            TableRow(children: [
              _buildRow(
                Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        child: new CircularProgressIndicator(
                          strokeWidth: 7,
                          value: _getTotalScore(vm.questionStats) / 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                            child: Text(
                      _getTotalScore(vm.questionStats).toInt().toString() + "%",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ))),
                  ],
                ),
              ),
              _buildRow(Text.rich(TextSpan(
                  text: '42',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                        text: 'nd',
                        style: TextStyle(fontSize: 15, color: Colors.white))
                  ]))),
              _buildRow(Text(
                StopWatchTimer.getDisplayTime(vm.fullQuestionTime,
                    hours: false, milliSecond: false),
                style: TextStyle(color: Colors.white),
              )),
            ])
          ],
        ));

    final table = Table(
      children: [
        TableRow(
          children: [
            _buildRow(Text(
              'Topic',
              style: headerStyle,
            )),
            _buildRow(Text(
              'Time',
              style: headerStyle,
            )),
            _buildRow(Text(
              'Performance',
              style: headerStyle,
            )),
          ],
        ),
        ...vm.questionStats.entries.map((e) {
          var performance = ((e.value.correctAnswers / e.value.numOfQuestion));
          log(performance.toString());
          return TableRow(children: [
            _buildRow(Text(
              e.key,
              style: headerStyle,
            )),
            _buildRow(Text(
              StopWatchTimer.getDisplayTimeSecond(e.value.time),
              style: TextStyle(fontSize: 10, color: Colors.white),
            )),
            _buildRow(Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: LinearProgressIndicator(
                value: performance,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(performance > 0.7
                    ? AppColors.background01
                    : performance > 0.4
                        ? Colors.amber
                        : Colors.red),
              ),
            ))
          ]);
        }).toList()
      ],
    );

    final prompt = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Want to review and improve your performance?  \n click on the button below',
        style: headerStyle,
        textAlign: TextAlign.center,
      ),
    );

    final button = CustomButton(
      onPressed: () => router.pushNamedAndRemoveUntil(AppRoutes.welcomeRoute),
      isOutline: false,
      text: AppString.buySubscription,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade800,
          child: Column(
            children: [
              top,
              verticalSpacer(),
              Expanded(child: table),
              verticalSpacer(),
              prompt,
              verticalSpacer(),
              button
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(Widget widget) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: widget,
      ),
    );
  }

  double _getTotalScore(Map<String, Stats> sts) {
    int totalQuestion = 0, totalCorrect = 0;
    for (var i in sts.entries) {
      totalQuestion = totalQuestion + i.value.numOfQuestion;
      totalCorrect = totalCorrect + i.value.correctAnswers;
    }
    return (totalCorrect / totalQuestion) * 100;
  }
}
