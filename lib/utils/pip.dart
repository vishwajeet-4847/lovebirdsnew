import 'dart:io';
import 'package:flutter/services.dart';

class Pip {
  static const MethodChannel _channel = MethodChannel('pip');
  static const EventChannel _events = EventChannel('pip_events');

  /// Stream of PiP state changes (true when in PiP, false otherwise)
  static Stream<bool> get events {
    if (!Platform.isAndroid) {
      // Emit a single false on non-Android
      return const Stream<bool>.empty();
    }
    return _events.receiveBroadcastStream().map((dynamic v) => v == true);
  }

  /// Enter Android Picture-in-Picture mode. Returns true if the request was sent.
  static Future<bool> enterPip({int width = 9, int height = 16}) async {
    if (!Platform.isAndroid) return false;
    try {
      final ok = await _channel.invokeMethod<bool>('enterPip', {
        'width': width,
        'height': height,
      });
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Whether PiP is supported on this device (Android O+).
  static Future<bool> isAvailable() async {
    if (!Platform.isAndroid) return false;
    try {
      final ok = await _channel.invokeMethod<bool>('isPipAvailable');
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Whether the app is currently in PiP.
  static Future<bool> isInPip() async {
    if (!Platform.isAndroid) return false;
    try {
      final ok = await _channel.invokeMethod<bool>('isInPip');
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }
}
