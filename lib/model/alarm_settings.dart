import 'package:alarm/model/notification_settings.dart';
import 'package:flutter/foundation.dart';

@immutable

/// [AlarmSettings] is a model that contains all the settings to customize
/// and set an alarm.
class AlarmSettings {
  /// Constructs an instance of `AlarmSettings`.
  const AlarmSettings({
    required this.id,
    required this.dateTime,
    required this.assetAudioPath,
    required this.notificationSettings,
    this.loopAudio = true,
    this.vibrate = true,
    this.volume,
    this.fadeDuration = 0.0,
    this.fadeStopTimes = const [],
    this.fadeStopVolumes = const [],
    this.warningNotificationOnKill = true,
    this.androidFullScreenIntent = true,
  });

  /// Constructs an `AlarmSettings` instance from the given JSON data.
  factory AlarmSettings.fromJson(Map<String, dynamic> json) {
    NotificationSettings notificationSettings;

    // Ensure compatibility with plugin versions below 4.0.0.
    if (json.containsKey('notificationSettings') &&
        json['notificationSettings'] != null) {
      notificationSettings = NotificationSettings.fromJson(
        json['notificationSettings'] as Map<String, dynamic>,
      );
    } else {
      final notificationTitle = json['notificationTitle'] as String? ?? '';
      final notificationBody = json['notificationBody'] as String? ?? '';

      notificationSettings = NotificationSettings(
        title: notificationTitle,
        body: notificationBody,
      );
    }

    final warningNotificationOnKill =
        json.containsKey('warningNotificationOnKill')
            ? json['warningNotificationOnKill'] as bool
            : json['enableNotificationOnKill'] as bool? ?? true;

    return AlarmSettings(
      id: json['id'] as int,
      dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
      assetAudioPath: json['assetAudioPath'] as String,
      notificationSettings: notificationSettings,
      loopAudio: json['loopAudio'] as bool? ?? true,
      vibrate: json['vibrate'] as bool? ?? true,
      volume: json['volume'] as double?,
      fadeDuration: json['fadeDuration'] as double? ?? 0.0,
      fadeStopTimes: (json['fadeStopTimes'] as List<dynamic>?)
              ?.map((e) => e as double)
              .toList(growable: false) ??
          [],
      fadeStopVolumes: (json['fadeStopVolumes'] as List<dynamic>?)
              ?.map((e) => e as double)
              .toList(growable: false) ??
          [],
      warningNotificationOnKill: warningNotificationOnKill,
      androidFullScreenIntent: json['androidFullScreenIntent'] as bool? ?? true,
    );
  }

  /// Unique identifier assiocated with the alarm. Cannot be 0 or -1;
  final int id;

  /// Date and time when the alarm will be triggered.
  final DateTime dateTime;

  /// Path to audio asset to be used as the alarm ringtone. Accepted formats:
  ///
  /// * **Project asset**: Specifies an asset bundled with your Flutter project.
  ///  Use this format for assets that are included in your project's
  /// `pubspec.yaml` file.
  ///  Example: `assets/audio.mp3`.
  /// * **Absolute file path**: Specifies a direct file system path to the
  /// audio file. This format is used for audio files stored outside the
  /// Flutter project, such as files saved in the device's internal
  /// or external storage.
  ///  Example: `/path/to/your/audio.mp3`.
  /// * **Relative file path**: Specifies a file path relative to a predefined
  /// base directory in the app's internal storage. This format is convenient
  /// for referring to files that are stored within a specific directory of
  /// your app's internal storage without needing to specify the full path.
  ///  Example: `Audios/audio.mp3`.
  ///
  /// If you want to use aboslute or relative file path, you must request
  /// android storage permission and add the following permission to your
  /// `AndroidManifest.xml`:
  /// `android.permission.READ_EXTERNAL_STORAGE`
  final String assetAudioPath;

  /// Settings for the notification.
  final NotificationSettings notificationSettings;

  /// If true, [assetAudioPath] will repeat indefinitely until alarm is stopped.
  final bool loopAudio;

  /// If true, device will vibrate for 500ms, pause for 500ms and repeat until
  /// alarm is stopped.
  ///
  /// If [loopAudio] is set to false, vibrations will stop when audio ends.
  final bool vibrate;

  /// Specifies the system volume level to be set at the designated [dateTime].
  ///
  /// Accepts a value between 0 (mute) and 1 (maximum volume).
  /// When the alarm is triggered at [dateTime], the system volume adjusts to
  /// this specified level. Upon stopping the alarm, the system volume reverts
  /// to its prior setting.
  ///
  /// If left unspecified or set to `null`, the current system volume
  /// at the time of the alarm will be used.
  /// Defaults to `null`.
  final double? volume;

  /// Duration, in seconds, over which to fade the alarm ringtone.
  /// Set to 0.0 by default, which means no fade.
  final double fadeDuration;

  /// Together with [fadeStopVolumes] controls how the alarm volume will fade
  /// over time.
  ///
  /// Set to empty list by default, which means no fade.
  ///
  /// Must have positive values and the same length as [fadeStopVolumes].
  ///
  /// Example:
  ///    fadeStopTimes = [0, 10, 20]
  ///    fadeStopVolumes = [0, 0.5, 1.0]
  /// The alarm will begin silent, fade to 50% of max volume by 10 seconds,
  /// and fade to max volume by 20 seconds.
  final List<double> fadeStopTimes;

  /// Together with [fadeStopTimes] controls how the alarm volume will fade
  /// over time.
  ///
  /// Set to empty list by default, which means no fade.
  ///
  /// Must have values that are in [0, 1] and have the same length as
  /// [fadeStopTimes].
  ///
  /// See [fadeStopTimes] for more information.
  final List<double> fadeStopVolumes;

  /// Whether to show a warning notification when application is killed by user.
  ///
  /// - **Android**: the alarm should still trigger even if the app is killed,
  /// if configured correctly and with the right permissions.
  /// - **iOS**: the alarm will not trigger if the app is killed.
  ///
  /// Recommended: set to `Platform.isIOS` to enable it only
  /// on iOS. Defaults to `true`.
  final bool warningNotificationOnKill;

  /// Whether to turn screen on and display full screen notification
  /// when android alarm notification is triggered. Enabled by default.
  ///
  /// Some devices will need the Autostart permission to show the full screen
  /// notification. You can check if the permission is granted and request it
  /// with the [auto_start_flutter](https://pub.dev/packages/auto_start_flutter)
  /// package.
  final bool androidFullScreenIntent;

  /// Returns a hash code for this `AlarmSettings` instance using
  /// Jenkins hash function.
  @override
  int get hashCode {
    var hash = 0;

    hash = hash ^ id.hashCode;
    hash = hash ^ dateTime.hashCode;
    hash = hash ^ assetAudioPath.hashCode;
    hash = hash ^ notificationSettings.hashCode;
    hash = hash ^ loopAudio.hashCode;
    hash = hash ^ vibrate.hashCode;
    hash = hash ^ volume.hashCode;
    hash = hash ^ fadeDuration.hashCode;
    hash = hash ^ Object.hashAll(fadeStopTimes);
    hash = hash ^ Object.hashAll(fadeStopVolumes);
    hash = hash ^ warningNotificationOnKill.hashCode;
    hash = hash ^ androidFullScreenIntent.hashCode;
    hash = hash & 0x3fffffff;

    return hash;
  }

  /// Creates a copy of `AlarmSettings` but with the given fields replaced with
  /// the new values.
  AlarmSettings copyWith({
    int? id,
    DateTime? dateTime,
    String? assetAudioPath,
    NotificationSettings? notificationSettings,
    bool? loopAudio,
    bool? vibrate,
    double? volume,
    double? fadeDuration,
    List<double>? fadeStopTimes,
    List<double>? fadeStopVolumes,
    String? notificationTitle,
    String? notificationBody,
    bool? warningNotificationOnKill,
    bool? androidFullScreenIntent,
  }) {
    return AlarmSettings(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      assetAudioPath: assetAudioPath ?? this.assetAudioPath,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      loopAudio: loopAudio ?? this.loopAudio,
      vibrate: vibrate ?? this.vibrate,
      volume: volume ?? this.volume,
      fadeDuration: fadeDuration ?? this.fadeDuration,
      fadeStopTimes: fadeStopTimes ?? this.fadeStopTimes,
      fadeStopVolumes: fadeStopVolumes ?? this.fadeStopVolumes,
      warningNotificationOnKill:
          warningNotificationOnKill ?? this.warningNotificationOnKill,
      androidFullScreenIntent:
          androidFullScreenIntent ?? this.androidFullScreenIntent,
    );
  }

  /// Converts this `AlarmSettings` instance to JSON data.
  Map<String, dynamic> toJson() => {
        'id': id,
        'dateTime': dateTime.microsecondsSinceEpoch,
        'assetAudioPath': assetAudioPath,
        'notificationSettings': notificationSettings.toJson(),
        'loopAudio': loopAudio,
        'vibrate': vibrate,
        'volume': volume,
        'fadeDuration': fadeDuration,
        'fadeStopTimes': fadeStopTimes,
        'fadeStopVolumes': fadeStopVolumes,
        'warningNotificationOnKill': warningNotificationOnKill,
        'androidFullScreenIntent': androidFullScreenIntent,
      };

  /// Returns all the properties of `AlarmSettings` for debug purposes.
  @override
  String toString() {
    final json = toJson();
    json['dateTime'] =
        DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int);

    return 'AlarmSettings: $json';
  }

  /// Compares two AlarmSettings.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmSettings &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateTime == other.dateTime &&
          assetAudioPath == other.assetAudioPath &&
          notificationSettings == other.notificationSettings &&
          loopAudio == other.loopAudio &&
          vibrate == other.vibrate &&
          volume == other.volume &&
          fadeDuration == other.fadeDuration &&
          listEquals(fadeStopTimes, other.fadeStopTimes) &&
          listEquals(fadeStopVolumes, other.fadeStopVolumes) &&
          warningNotificationOnKill == other.warningNotificationOnKill &&
          androidFullScreenIntent == other.androidFullScreenIntent;
}
