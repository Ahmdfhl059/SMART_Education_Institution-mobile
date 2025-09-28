import 'package:firebase_messaging/firebase_messaging.dart';
import '/data/repo/fcm_token_repo.dart';
// import '/core/repos/fcm_token_repo.dart';

  var fcmTokenRepo = FCMTokenRepo();
Future<String> getToken() async{
  String fcmValue = 'init';
  await FirebaseMessaging.instance.getToken().then((value) {
    print('value::::: ::::: ===== ${value}');
    // fcmTokenRepo.postFCMToken(value.toString());
    fcmValue = value.toString();
     return value.toString();
  }).onError((err, s) {
    return 'error';
  });
  return fcmValue;
}
Future<String> deleteToken() async{
  await FirebaseMessaging.instance.deleteToken();

  return '';
}


Future<String> getTokenOnRefresh()async {
  print('start sending fcmtoken ================================');
  String token = '';
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken){
    // print(object)
    fcmTokenRepo.postFCMToken(fcmToken);
    token = fcmToken;
  }).onError((err) {
    throw Exception('');
  });
  return token;
}