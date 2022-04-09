import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/providers/base.provider.dart';

class LevelProvider extends BaseProvider{

  int selectedLevel;
  List options = AppString.levelOptions;

  @override
  void initProvider() {
    // TODO: implement initProvider
    super.initProvider();
    selectedLevel =  options.first['value'];
  }

  void onChangeLevel( value){
    selectedLevel = value;
    notifyListeners();
  }

}