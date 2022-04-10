import 'package:adeo_app/providers/class.provider.dart';
import 'package:adeo_app/providers/level.provider.dart';
import 'package:adeo_app/providers/question.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LevelProvider>.value(
    value: LevelProvider(),
  ),
  ChangeNotifierProvider<ClassProvider>.value(
    value: ClassProvider(),
  ),
  ChangeNotifierProvider<QuestionProvider>.value(
    value: QuestionProvider(),
  ),
];
