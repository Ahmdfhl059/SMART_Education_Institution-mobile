import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String pageUrl) async {
  final Uri url = Uri.parse(pageUrl);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch $url");
  }
}

// Future<void> openFacebook(String pageUrl) async {
//   final Uri url = Uri.parse(pageUrl);
//   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//     throw Exception("Could not launch $url");
//   }
// }
//
// Future<void> openInstagram(String username) async {
//   final Uri url = Uri.parse("https://instagram.com/$username");
//   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//     throw Exception("Could not launch $url");
//   }
// }
