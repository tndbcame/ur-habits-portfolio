import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitDetailListTile extends StatefulWidget {
  /// 習慣詳細画面の共通タイル
  const HabitDetailListTile({
    super.key,
    required this.title,
    required this.mainItem,
    required this.itemHeight,
    this.onTap,
    this.attachAllow,
    this.isRequiredMark = false,
    this.isFinal,
    this.isDropDown,
  });

  final String title;
  final Widget mainItem;
  final double itemHeight;
  final VoidCallback? onTap;
  final bool? attachAllow;
  final bool isRequiredMark;
  final bool? isFinal;
  final bool? isDropDown;

  @override
  State<HabitDetailListTile> createState() => _HabitDetailListTileState();
}

class _HabitDetailListTileState extends State<HabitDetailListTile> {
  Color? backgroundColor;

  /// タップ時の処理 - 背景色を変更
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      if (widget.onTap != null) backgroundColor = kLightGray8;
    });
  }

  /// タップ解除時の処理 - 背景色をリセット
  void _handleTapUp(TapUpDetails details) {
    setState(() {
      backgroundColor = null;
    });
  }

  /// タップキャンセル時の処理 - 背景色をリセット
  void _handleTapCancel() {
    setState(() {
      backgroundColor = null;
    });
  }

  /// タイル全体のコンテナを構築
  Widget _buildTileContainer() {
    return Container(
      height: widget.itemHeight,
      decoration: _buildBoxDecoration(),
      child: Padding(
        padding: _setPadding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleBox(),
            if (widget.attachAllow == true) const SizedBox(width: 24),
            _buildSpacing(),
            widget.mainItem,
            if (widget.attachAllow == true) _buildArrowIcon(),
          ],
        ),
      ),
    );
  }

  /// タイルのボックス装飾
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      border: widget.isFinal == true
          ? null
          : const Border(
              bottom: BorderSide(
                width: 1.0,
                color: kLightGray2,
              ),
            ),
    );
  }

  /// パディング設定
  EdgeInsets _setPadding() {
    return widget.isDropDown == true
        ? const EdgeInsets.fromLTRB(10, 10, 0, 10)
        : const EdgeInsets.all(10);
  }

  /// タイトルボックスの構築
  Widget _buildTitleBox() {
    return SizedBox(
      width: 115,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                color: kTextThirdBaseColor,
              ),
            ),
            if (widget.isRequiredMark)
              const Icon(
                CommunityMaterialIcons.asterisk,
                size: 8,
              )
          ],
        ),
      ),
    );
  }

  /// スペースを設定
  Widget _buildSpacing() {
    return SizedBox(
      width: widget.attachAllow == true ? 30 : 20,
    );
  }

  /// 矢印アイコンの表示
  Widget _buildArrowIcon() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: Icon(
        HugeIcons.strokeRoundedArrowRight01,
        size: 36,
        color: kTextThirdBaseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: _buildTileContainer(),
    );
  }
}
