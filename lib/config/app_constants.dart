import 'package:flutter/foundation.dart';

class AppConstants {
  AppConstants._();
  static const String appName = 'Gully Cricket';
  static const baseUrl = kReleaseMode
      ? "http://3.109.65.55:5000/api"
      : "http://192.168.29.3:3000/api";
  static const websocketUrl =
      kReleaseMode ? "ws://13.233.149.139:3001" : "ws://13.233.149.139:3001";
  static const String s3BucketUrl =
      "https://gully-team-bucket.s3.amazonaws.com/";
}
