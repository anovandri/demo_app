import 'package:intl/intl.dart';

class Util {

  static DateTime convertDateFromString(String strDate) {
    var df = DateFormat().add_d().add_MMM().add_y().parse(strDate);    
    return df;
  } 
}
