import 'package:intl/intl.dart';

class PriceUtils {
  static final oCcy = NumberFormat("#,###", "ko_KR");
  static String calcStringToWon(String priceString) {
    if (priceString != "") {
      return "${oCcy.format(int.parse(priceString))} 원";
    } else {
      return "- 원";
    }
  }
}
