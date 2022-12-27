import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'http://34.128.80.67/';
  static const apiKey = 'API_KEY';
  static const notificationChannelId = 'bootcamp_challenge2_channel_id';
  static const notificationChannelName = 'bootcamp_challenge2 notification';
  static const notificationChannelDesc = 'bootcamp_challenge2 notification';
  static const savedNotification = 'FCM_MESSAGE';
  static const timeout = kDebugMode ? 90 * 1000 : 10 * 1000;
}
