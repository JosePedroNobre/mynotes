import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mynotes/network/error_handling/api_error.dart';

class ErrorHelper {
  final StreamController<ApiError> errorStream = StreamController<ApiError>.broadcast();
  bool _isBroadcasting = false;
  Completer<void>? _broadcastCompleter;

  void dispose() {
    errorStream.close();
  }

  void broadcastError(Object e, {bool reportError = true}) async {
    if (_isBroadcasting) {
      return;
    }

    if (_broadcastCompleter != null && !_broadcastCompleter!.isCompleted) {
      return;
    }

    String message = e is ApiError ? e.message : e.toString();

    if (shouldIgnoreError(message)) {
      return;
    }

    _startBroadcast();
    if (!kDebugMode) {
      if (reportError) {
        _reportErrorToCrashlytics(message);
      }
    }
    errorStream.sink.add(ApiError(message: message));
    _scheduleBroadcastCompleter();
  }

  bool shouldIgnoreError(String errorMessage) {
    List<String> ignoreList = ['timeout', 'bad state', 'connection reset', 'cancelled', '[unknown]: null'];
    return ignoreList.any((ignoreMessage) => errorMessage.toLowerCase().contains(ignoreMessage));
  }

  void _startBroadcast() {
    _isBroadcasting = true;
  }

  void _endBroadcast() {
    _isBroadcasting = false;
  }

  void _scheduleBroadcastCompleter() {
    _broadcastCompleter = Completer<void>();
    _broadcastCompleter?.future.then((_) {
      _endBroadcast();
      _broadcastCompleter = null;
    });
    if (_broadcastCompleter != null && !(_broadcastCompleter?.isCompleted ?? true)) {
      _broadcastCompleter?.complete();
    }
  }

  static void _reportErrorToCrashlytics(String errorMessage) {}
}
