import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_dialog.dart';

/// オーバーレイ表示の管理を行うクラス
class OverlayManager {
  /// シングルトンで実装
  static final OverlayManager _instance = OverlayManager._internal();
  factory OverlayManager() {
    return _instance;
  }
  OverlayManager._internal();

  OverlayEntry? _overlayEntry;
  AnimationController? _controller;
  Animation<double>? _animation;

  /// オーバーレイを表示する
  void showOverlay(BuildContext context, TickerProvider vsync, String message) {
    if (_overlayEntry != null) return;

    // AnimationController と Animation の初期化
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.decelerate,
    );

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return OverlayDialog(
          message: message,
          animatoin: _animation!,
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller!.forward();
  }

  /// オーバーレイを削除する
  void removeOverlay() {
    if (_overlayEntry == null) return; // オーバーレイが表示されていない場合は何もしない

    _controller!.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _controller?.dispose();
      _controller = null;
    });
  }

  /// 一定時間後にオーバーレイでダイアログを表示し、オーバーレイを削除する
  void showOverlayDialog(
    BuildContext context,
    TickerProvider vsync,
    String message,
  ) {
    showOverlay(context, vsync, message);
    // 1秒後にオーバーレイを削除
    Timer(const Duration(seconds: 1), () => removeOverlay());
  }
}
