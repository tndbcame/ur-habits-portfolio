import 'package:flutter/cupertino.dart';

class TimeDialogController {
  // コンストラクタ：時間、分、秒の初期値を設定
  TimeDialogController({
    int? initialHour,
    int? initialMinute,
    int? initialSecond,
  })  : hourController =
            FixedExtentScrollController(initialItem: initialHour ?? 0),
        minuteController =
            FixedExtentScrollController(initialItem: initialMinute ?? 0),
        secondController =
            FixedExtentScrollController(initialItem: initialSecond ?? 0);

  // 各時間単位のコントローラー
  final FixedExtentScrollController hourController;
  final FixedExtentScrollController minuteController;
  final FixedExtentScrollController secondController;

  /// 指定した時間にスクロールを移動させる
  void setTime(DateTime time) {
    _animateToItem(hourController, time.hour);
    _animateToItem(minuteController, time.minute);
    _animateToItem(secondController, time.second);
  }

  /// アニメーションで指定したアイテムにスクロールさせる
  void _animateToItem(FixedExtentScrollController controller, int value) {
    controller.animateToItem(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  /// コントローラーを破棄する
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
  }
}
