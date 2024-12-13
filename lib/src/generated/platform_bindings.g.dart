// Autogenerated from Pigeon (v22.7.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse(
    {Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

/// Errors that can occur when interacting with the Alarm API.
enum AlarmErrorCode {
  unknown,

  /// A plugin internal error. Please report these as bugs on GitHub.
  pluginInternal,

  /// The arguments passed to the method are invalid.
  invalidArguments,

  /// An error occurred while communicating with the native platform.
  channelError,

  /// The required notification permission was not granted.
  ///
  /// Please use an external permission manager such as "permission_handler" to
  /// request the permission from the user.
  missingNotificationPermission,
}

class AlarmSettingsWire {
  AlarmSettingsWire({
    required this.id,
    required this.millisecondsSinceEpoch,
    required this.assetAudioPath,
    required this.volumeSettings,
    required this.notificationSettings,
    this.loopAudio = true,
    this.vibrate = true,
    this.warningNotificationOnKill = true,
    this.androidFullScreenIntent = true,
    this.allowAlarmOverlap = false,
  });

  int id;

  int millisecondsSinceEpoch;

  String assetAudioPath;

  VolumeSettingsWire volumeSettings;

  NotificationSettingsWire notificationSettings;

  bool loopAudio;

  bool vibrate;

  bool warningNotificationOnKill;

  bool androidFullScreenIntent;

  bool allowAlarmOverlap;

  Object encode() {
    return <Object?>[
      id,
      millisecondsSinceEpoch,
      assetAudioPath,
      volumeSettings,
      notificationSettings,
      loopAudio,
      vibrate,
      warningNotificationOnKill,
      androidFullScreenIntent,
      allowAlarmOverlap,
    ];
  }

  static AlarmSettingsWire decode(Object result) {
    result as List<Object?>;
    return AlarmSettingsWire(
      id: result[0]! as int,
      millisecondsSinceEpoch: result[1]! as int,
      assetAudioPath: result[2]! as String,
      volumeSettings: result[3]! as VolumeSettingsWire,
      notificationSettings: result[4]! as NotificationSettingsWire,
      loopAudio: result[5]! as bool,
      vibrate: result[6]! as bool,
      warningNotificationOnKill: result[7]! as bool,
      androidFullScreenIntent: result[8]! as bool,
      allowAlarmOverlap: result[9]! as bool,
    );
  }
}

class VolumeSettingsWire {
  VolumeSettingsWire({
    this.volume,
    this.fadeDurationMillis,
    required this.fadeSteps,
    required this.volumeEnforced,
  });

  double? volume;

  int? fadeDurationMillis;

  List<VolumeFadeStepWire> fadeSteps;

  bool volumeEnforced;

  Object encode() {
    return <Object?>[
      volume,
      fadeDurationMillis,
      fadeSteps,
      volumeEnforced,
    ];
  }

  static VolumeSettingsWire decode(Object result) {
    result as List<Object?>;
    return VolumeSettingsWire(
      volume: result[0] as double?,
      fadeDurationMillis: result[1] as int?,
      fadeSteps: (result[2] as List<Object?>?)!.cast<VolumeFadeStepWire>(),
      volumeEnforced: result[3]! as bool,
    );
  }
}

class VolumeFadeStepWire {
  VolumeFadeStepWire({
    required this.timeMillis,
    required this.volume,
  });

  int timeMillis;

  double volume;

  Object encode() {
    return <Object?>[
      timeMillis,
      volume,
    ];
  }

  static VolumeFadeStepWire decode(Object result) {
    result as List<Object?>;
    return VolumeFadeStepWire(
      timeMillis: result[0]! as int,
      volume: result[1]! as double,
    );
  }
}

class NotificationSettingsWire {
  NotificationSettingsWire({
    required this.title,
    required this.body,
    this.stopButton,
    this.icon,
  });

  String title;

  String body;

  String? stopButton;

  String? icon;

  Object encode() {
    return <Object?>[
      title,
      body,
      stopButton,
      icon,
    ];
  }

  static NotificationSettingsWire decode(Object result) {
    result as List<Object?>;
    return NotificationSettingsWire(
      title: result[0]! as String,
      body: result[1]! as String,
      stopButton: result[2] as String?,
      icon: result[3] as String?,
    );
  }
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is AlarmErrorCode) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is AlarmSettingsWire) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is VolumeSettingsWire) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is VolumeFadeStepWire) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is NotificationSettingsWire) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : AlarmErrorCode.values[value];
      case 130:
        return AlarmSettingsWire.decode(readValue(buffer)!);
      case 131:
        return VolumeSettingsWire.decode(readValue(buffer)!);
      case 132:
        return VolumeFadeStepWire.decode(readValue(buffer)!);
      case 133:
        return NotificationSettingsWire.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class AlarmApi {
  /// Constructor for [AlarmApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  AlarmApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<void> setAlarm({required AlarmSettingsWire alarmSettings}) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.setAlarm$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
        .send(<Object?>[alarmSettings]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> stopAlarm({required int alarmId}) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.stopAlarm$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alarmId]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> stopAll() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.stopAll$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> isRinging({required int? alarmId}) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.isRinging$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alarmId]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<void> setWarningNotificationOnKill(
      {required String title, required String body}) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.setWarningNotificationOnKill$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[title, body]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> disableWarningNotificationOnKill() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.alarm.AlarmApi.disableWarningNotificationOnKill$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class AlarmTriggerApi {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  Future<void> alarmRang(int alarmId);

  Future<void> alarmStopped(int alarmId);

  static void setUp(
    AlarmTriggerApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmRang$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmRang was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_alarmId = (args[0] as int?);
          assert(arg_alarmId != null,
              'Argument for dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmRang was null, expected non-null int.');
          try {
            await api.alarmRang(arg_alarmId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmStopped$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmStopped was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_alarmId = (args[0] as int?);
          assert(arg_alarmId != null,
              'Argument for dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmStopped was null, expected non-null int.');
          try {
            await api.alarmStopped(arg_alarmId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
