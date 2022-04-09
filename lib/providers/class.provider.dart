
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/providers/base.provider.dart';

class ClassProvider extends BaseProvider{

  int selectedClass;
  List classOptions = AppString.classOptions;


  @override
  void initProvider() {
    // TODO: implement initProvider
    super.initProvider();
    selectedClass = classOptions.first['value'];
  }

  void onChangeClass( value){
    selectedClass = value;
    notifyListeners();
  }
}