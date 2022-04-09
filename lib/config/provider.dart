import 'package:adeo_app/providers/level.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LevelProvider>.value(
    value: LevelProvider(),
  ),
];
