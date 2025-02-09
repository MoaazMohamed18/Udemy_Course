import '../../Shop_app/modules/login/shop_loginScreen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=537fd47cd2a74c659b909ebe97d1f1b4

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
String? uId = '';
