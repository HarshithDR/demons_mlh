import 'package:audioplayers/audioplayers.dart';

class NotificationSound {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playNotificationSound() async {
    try {
      await _player.play(
        AssetSource('/assets/images/fire.mp3'),
      ); // Ensure the file exists in assets
    } catch (e) {
      print('Error playing sound: $e');
    }
  }
}
