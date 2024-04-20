import 'dart:developer';

import 'package:url_launcher/url_launcher.dart' as app_url_launcher;

class UrlService {
  launchUrl(String url) async {
    log('Launching download url : $url');
    await app_url_launcher.canLaunchUrl(Uri.parse(url))
        ? await app_url_launcher.launchUrl(Uri.parse(url))
        : throw Exception("Could not launch $url");
  }
}
