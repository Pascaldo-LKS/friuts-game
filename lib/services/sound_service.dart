import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'settings_service.dart';

class SoundService {
  // 🎵 Player pour effets
  static final AudioPlayer _player = AudioPlayer();

  // 🎶 Player pour musique de fond
  static final AudioPlayer _bgPlayer = AudioPlayer();

  // 🔊 Son clic
  static Future<void> playClick() async {
    if (!SettingsService.soundEnabled) return;

    await _player.play(AssetSource('sounds/click.wav'));

    bool hasVibrator = await Vibration.hasVibrator() ?? false;

    if (hasVibrator) {
      Vibration.vibrate(duration: 300);
    }
  }

  // ✅ Son succès
  static Future<void> playSuccess() async {
    if (!SettingsService.soundEnabled) return;

    await _player.play(AssetSource('sounds/success.wav'));

    bool hasVibrator = await Vibration.hasVibrator() ?? false;

    if (hasVibrator) {
      Vibration.vibrate(duration: 300);
    }
  }

  // ❌ Son erreur
  static Future<void> playError() async {
    if (!SettingsService.soundEnabled) return;

    await _player.play(AssetSource('sounds/error.wav'));

    bool hasVibrator = await Vibration.hasVibrator() ?? false;

    if (hasVibrator) {
      Vibration.vibrate(duration: 300);
    }
  }

  // 🎵 Musique de fond (loop)
  static Future<void> playBackgroundMusic() async {
    if (!SettingsService.soundEnabled) return;

    await _bgPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgPlayer.play(AssetSource('sounds/bg_music.wav'));
  }

  // ⏹️ Stop musique
  static Future<void> stopBackgroundMusic() async {
    await _bgPlayer.stop();
  }
}
